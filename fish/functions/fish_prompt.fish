# Entropy prompt theme, by Justin Mayer <http://justinmayer.com/>
function fish_prompt -d "Write out the prompt"

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_virtualenv_color
        set -g __fish_prompt_virtualenv_color (set_color blue)
    end

    if not set -q __fish_prompt_userhost_color
        set -g __fish_prompt_userhost_color (set_color blue)
    end

    if not set -q __fish_prompt_repo_branch_color
        set -g __fish_prompt_repo_branch_color (set_color magenta)
    end

    if not set -q __fish_prompt_repo_status_color
        set -g __fish_prompt_repo_status_color (set_color blue)
    end

    if not set -q __fish_prompt_gray
        set -g __fish_prompt_gray (set_color -o black)
    end

    # If vcprompt detects PWD is a git/hg repo, call native VCS prompt function
    set -g __vcsystem (vcprompt -f "%n")

    if test -z $__vcsystem
        set -g __vcprompt
    else

        switch $__vcsystem

            case 'git*'

            set -g __fish_git_prompt_showdirtystate "True"
            set -g __fish_git_prompt_char_dirtystate "!"
            set -g __fish_git_prompt_color_dirtystate "blue"
            set -g __fish_git_prompt_showuntrackedfiles "True"
            set -g __fish_git_prompt_char_untrackedfiles "?"
            set -g __fish_git_prompt_color_untrackedfiles "blue"
            set -g __fish_git_prompt_color_branch "magenta"
            set -g __vcprompt $__fish_prompt_gray' on '(__fish_git_prompt "%s" | sed 's/ //')

            case 'hg*'

            set hg_promptstring "$__fish_prompt_gray< on $__fish_prompt_repo_branch_color<bookmark>>$__fish_prompt_repo_status_color<status|modified|unknown><update>$__fish_prompt_normal"
            set -g __vcprompt (hg prompt --angle-brackets $hg_promptstring)

        end

    end

    switch $USER

        case root

        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
            else
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end
        end

        set -g __fish_prompt_char ' # '

        case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

        set -g __fish_prompt_char ' ➤ '

    end

    if [ -z $SSH_CONNECTION ]

        if not set -q __fish_prompt_userhost
            set -g __fish_prompt_userhost
        end

    else

        if not set -q __fish_prompt_userhost
            set -g __fish_prompt_userhost $__fish_prompt_userhost_color$USER"@"$__fish_prompt_hostname" "
        end

    end

    if set -q VIRTUAL_ENV
        if not set -q __fish_prompt_virtualenv
            set __fish_prompt_virtualenv $__fish_prompt_virtualenv_color"("(basename "$VIRTUAL_ENV")")"$__fish_prompt_normal" "
        end
    end

    echo -n -s "$__fish_prompt_userhost" "$__fish_prompt_virtualenv" "$__fish_prompt_cwd" (prompt_pwd) "$__vcprompt" "$__fish_prompt_normal" "$__fish_prompt_char"

end

# We've also included an example of how
# to determine the current project from the pwd.
# It'll only work without alterations if
# you happen to keep all your projects in
# ~/Sites/ on a Mac, but it's easy to modify

set -l project

if echo (pwd) | grep -qEi "^/Users/$USER/Repos/"
    set  project (echo (pwd) | sed "s#^/Users/$USER/Repos/\\([^/]*\\).*#\\1#")
else
    set  project "Terminal"
end
