% Overview of my dotfiles
% 
% 

Contents
========

-   [Git](#git)
-   [Vim](#vim)
    -   [Vim Markdown](#vim-markdown)
    -   [Fuzzy File Finder](#fuzzy-file-finder)
-   [Bash](#bash)

Git
===

1.  [David DeSandro](http://dropshado.ws/post/7844857440/gitconfig-colors) blog
    entry is a good start point.  
2.  [Cheat sheets](http://cheat.errtheblog.com/s/git) has more comprehensive entry.

Vim
===

1.  [Vrome](https://chrome.google.com/webstore/detail/godjoomfiimiddapohpmfklhgmbfffjj) is a Google Chrome extension.
2.  I use [Vundle](https://github.com/gmarik/vundle) to manage Vim packages.
3.  [vimoutliner/vimoutliner](https://github.com/vimoutliner/vimoutliner) is the only complete repo of VimOutliner plugin. More details are in [this commit message](https://github.com/talha131/dotfiles/commit/42a19d07581087f274c3b461f6908ec5b75af6a7).

Vim Markdown
------------

1.  [tpope/vim-markdown](https://github.com/tpope/vim-markdown) is mostly used. But it does not conceal text markers in Markdown file.
2.  [xolox/vim-markdown](https://github.com/xolox/vim-markdown) does the concealing. See [this image](https://github.com/tpope/vim-markdown/pull/9#issuecomment-3098050) for example.
3.  But you have to switch to xolox/vim-markdown `conceal` branch to get his code. Use `git checkout -b conceal remotes/origin/conceal` to
    checkout the branch.

Fuzzy File Finder
-----------------

1.  I tried [command-t](https://wincent.com/products/command-t/) but I could not make it work. It requires that your copy of vim should be compiled with the same version of ruby with which you compiled command-t, which effectively means you have to compile Vim yourself.
2.  I took the easier way, use [CtrlP](http://kien.github.com/ctrlp.vim/). It is basically the same as Command-T but written in pure Vimscript. This means it neither requires Ruby support enabled in Vim nor does it require the compilation of some Ruby extension implemented in C.
3.  Other extensions are either not what I wanted, for example, [LustyJuggler](http://www.vim.org/scripts/script.php?script_id%3D2050), or not actively maintained any more like [FuzzyFinder](http://www.vim.org/scripts/script.php?script_id%3D1984) and [fuzzy file finder](https://github.com/jamis/fuzzy_file_finder).

Bash
====

1.  Bash completion depends on bash\_completion package. MacPorts users can do `sudo port install git-core +bash_completion`.
2.  [Git Utilities You Can't Live Without](http://blog.bitfluent.com/post/27983389/git-utilities-you-cant-live-without) blog entry has an entry for Git aware PS1.
