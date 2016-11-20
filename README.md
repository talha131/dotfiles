# Windows

## Setup Vim

Get Vim compiled with Python, Ruby and Lua support from [this link](https://tuxproject.de/projects/vim/).

Create `%HOME%\bin` folder and put Vim folder in it.

Install Python, Ruby. Install Git for Windows.
Get Lua and curl.

Put Lua and curl in `%HOME%\bin` folder. 

Edit `%PATH%` so that Vim, curl and Lua are accessible.

You can check path of each command using `where` command.

curl comes with `git` but in some older version `--create-dirs` does not work so it is better to have the latest version of curl running.

## Create Soft Links to Vim Configuration

Start `cmd` with administrative privilege.

```
mklink %HOME%\.vimrc %HOME%\Repos\dotfiles\vim\vimrc
mklink /d %HOME%\.vim\ %HOME%\Repos\dotfiles\vim\vim\
```

## Change Direction of Scrolling

To invert the direction of scrolling (natural scrolling on macOS), run [following command](http://superuser.com/a/364353/42415) in PowerShell with adminstrative privileges.

```
Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Enum\HID\*\*\Device` Parameters FlipFlopWheel -EA 0 | ForEach-Object { Set-ItemProperty $_.PSPath FlipFlopWheel 1 }
```

To restore

```
Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Enum\HID\*\*\Device` Parameters FlipFlopWheel -EA 1 | ForEach-Object { Set-ItemProperty $_.PSPath FlipFlopWheel 0 }
```

Natural direction of scrolling is how you scroll on iPhone, Android and other touch devices. Content scrolls in the direction of your fingers.

## Remap Keys

Use [SharpKeys](https://sharpkeys.codeplex.com/) to map Caps Lock to Control. It edits the registry for you.

Map,

1. Caps Lock to Left Control
1. Left Control to Left Windows
1. Left Windows to Left Control

Then use [AutoHotKey](https://autohotkey.com/) to map

1. Left Control + Tab to Alt Tab

Combined with mappings done with SharpKeys, Left Windows + Tab will act like Alt + Tab, which is easier on my left thumb.

# I need to review following portion of this file. It's outdated
Overview of my dotfiles
=======================

These configuration files do not work out of the box. These are specific to my Mac OSX system.

Following are my not so comprehensive and perhaps out of date notes.

Git
===

1.  [David DeSandro](http://dropshado.ws/post/7844857440/gitconfig-colors) blog entry is a good start point.
2.  [Cheat sheets](http://cheat.errtheblog.com/s/git) has more comprehensive entry.

Vim
===

1.  [Vrome](https://chrome.google.com/webstore/detail/godjoomfiimiddapohpmfklhgmbfffjj) is a Google Chrome extension.
2.  I use [Vundle](https://github.com/gmarik/vundle) to manage Vim packages.
3.  [vimoutliner/vimoutliner](https://github.com/vimoutliner/vimoutliner) is the only complete repo of VimOutliner plugin. More details are in [this commit message](https://github.com/talha131/dotfiles/commit/42a19d07581087f274c3b461f6908ec5b75af6a7).

Auto Close
----------

1.  [SO thread](http://stackoverflow.com/q/883437/177116) has got some good comments.
1.  I decided to use Thiago Alves/Townk's [plugin](https://github.com/Townk/vim-autoclose).
1.  [Townk's plugin tutorial](http://www.vim.org/scripts/script.php?script_id=2009).

Vim Markdown
------------

1.  [tpope/vim-markdown](https://github.com/tpope/vim-markdown) is mostly used. But it does not conceal text markers in Markdown file.
2.  [xolox/vim-markdown](https://github.com/xolox/vim-markdown) does the concealing. See [this image](https://github.com/tpope/vim-markdown/pull/9#issuecomment-3098050) for example.
3.  But you have to switch to xolox/vim-markdown `conceal` branch to get his code. Use `git checkout -b conceal remotes/origin/conceal` to
    checkout the branch.

Fuzzy File Finder
-----------------

1.  I tried [command-t](https://wincent.com/products/command-t/) but I could not make it work. It requires that your copy of Vim should be compiled with the same version of ruby with which you compiled command-t, which effectively means you have to compile Vim yourself.
2.  I took the easier way, use [CtrlP](http://kien.github.com/ctrlp.vim/). It is basically the same as Command-T but written in pure Vimscript. This means it neither requires Ruby support enabled in Vim nor does it require the compilation of some Ruby extension implemented in C.
3.  Other extensions are either not what I wanted, for example, [LustyJuggler](http://www.vim.org/scripts/script.php?script_id%3D2050), or not actively maintained any more like [FuzzyFinder](http://www.vim.org/scripts/script.php?script_id%3D1984) and [fuzzy file finder](https://github.com/jamis/fuzzy_file_finder).

Bash
====

1.  Bash completion depends on bash\_completion package. MacPorts users can do `sudo port install git-core +bash_completion`.
2.  [Git Utilities You Can't Live Without](http://blog.bitfluent.com/post/27983389/git-utilities-you-cant-live-without) blog entry has an entry for Git aware PS1.
