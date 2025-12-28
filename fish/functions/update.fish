function update -d 'Update software to the latest versions'
    function _print
        set_color -o yellow
        echo "📌  $argv"
        set_color normal
    end

    switch $argv[1]
        case brew
            _print 'Updating Brew'
            brew update && brew upgrade && brew cleanup

        case fish
            _print 'Updating fish completions'
            fish_update_completions

        case npm
            _print 'Updating global NPM packages'
            npm update -g

        case all ''
            update brew
            update npm
            update fish

        case '*'
            set_color -o red
            echo '⚠️  Invalid argument. Valid values: all, brew, fish, npm'
            set_color normal
            return 1
    end
end

complete --no-files -c update -a all  -d 'Update all packages'
complete --no-files -c update -a brew -d 'Update, upgrade, and cleanup brew'
complete --no-files -c update -a fish -d 'Update fish completions'
complete --no-files -c update -a npm  -d 'Update global npm packages'
