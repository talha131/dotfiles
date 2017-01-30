# Table of Contents

<!-- vim-markdown-toc GFM -->
* [Development Environment on Windows](#development-environment-on-windows)
    * [Change Computer Name](#change-computer-name)
    * [Set Time](#set-time)
    * [Disable Automatic Updates](#disable-automatic-updates)
    * [Install Applications](#install-applications)
    * [Download Applications](#download-applications)
    * [Configure](#configure)
        * [Map Keys](#map-keys)
        * [Track Pad](#track-pad)
        * [Mouse Properties](#mouse-properties)
    * [Dotfiles](#dotfiles)
        * [Git](#git)
        * [Vim](#vim)
            * [Link to Vim Configuration](#link-to-vim-configuration)
            * [Install Vim-Plug](#install-vim-plug)
            * [Install Plugins](#install-plugins)
            * [Diff](#diff)
            * [Add gVim to Context Menu](#add-gvim-to-context-menu)
        * [AutoHotKey](#autohotkey)
        * [Install AutoJump](#install-autojump)
        * [Clink](#clink)
    * [Color Codes](#color-codes)
* [Outdated Content](#outdated-content)
    * [Overview of my dotfiles](#overview-of-my-dotfiles)
    * [Git](#git-1)
    * [Vim](#vim-1)
        * [Auto Close](#auto-close)
        * [Vim Markdown](#vim-markdown)
        * [Fuzzy File Finder](#fuzzy-file-finder)
    * [Bash](#bash)

<!-- vim-markdown-toc -->

# Development Environment on Windows

After installing a fresh copy of Windows 10, do following steps.

## Change Computer Name

Open *Advanced System Settings* using `rundll32.exe shell32.dll,Control_RunDLL sysdm.cpl,,1`.

1. Click on *Change* button
1. Rename

## Set Time

Open time and date settings using `control timedate.cpl`.

1. Set time zone
1. Use 24 hour time format

## Disable Automatic Updates

Windows 10 automatic updates mess up with drivers, rendering my machine unstable. I had to reinstall Windows 10 at least 10 times before learning my lesson to never to trust Windows 10 automatic updates.

1. Open `services.msc`. Stop and disable *Windows Update Service*
1. Open driver update setting. Run `rundll32.exe shell32.dll,Control_RunDLL sysdm.cpl,,2`. Click on *Device Installation Settings* and disable drivers updates.
1. Open `gpedit.msc`. *Computer Configuration* -> *Administrative Templates* -> *Windows Components* -> *Windows Update* -> *Configure Automatic Updates*
    1. Enable it
    1. Choose *Notify to download and notify to install*

Update Windows Defender manually. Later use *Windows Update MiniTool* for installing selective updates.

Also download [this tool](https://support.microsoft.com/en-us/kb/3073930) from Microsoft support website. It hasn't been of any use at the time of writing but just keep it in case it may prove useful.

## Install Applications

1. Install [Windows Update MiniTool](http://www.majorgeeks.com/files/details/windows_update_minitool.html)
1. Install [SyncTazor](https://github.com/canton7/SyncTrayzor)
	1. Sync with other computers
1. Install [1Password](https://1password.com/downloads/)
1. Install [Firefox Developer Edition](https://www.mozilla.org/en-US/firefox/developer/)
    1. Enable Firefox sync
    1. Login to RescueTime plugin
    1. Configure Pray Times plugin
    1. Install [1Password extension](https://agilebits.com/onepassword/extensions)
1. Install [RescueTime](https://www.rescuetime.com/get_rescuetime)
1. Install [ConEmu Windows Terminal](https://conemu.github.io/en/)
    1. Open *Settings* -> *Integration*. Click on *Register* to add ConEmu to context menu
1. Install [Clink](https://mridgers.github.io/clink/).
1. Install [Revo Uninstaller Freeware](http://www.revouninstaller.com/download-freeware-version.php)
1. Install [SharpKeys](https://sharpkeys.codeplex.com/)
1. Install [Git for Windows](https://git-for-windows.github.io/)
1. Setup [Qt](https://download.qt.io/archive/qt/)
	1. Install [Latest Qt Creator](https://www.qt.io/download-open-source/#section-9)
    1. Install [Qt `5.5.1` for Windows 32bit (VS 2013)](https://download.qt.io/archive/qt/5.5/5.5.1/)
1. Install CDB debugger for Qt
    1. Download [Windows 10 SDK online installer](https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk). Offline installer is [not available](http://superuser.com/a/1020752/42415)
    1. Either install it directly or choose to download only
    1. Installer will present a menu of features. Select *Debugging Tools for Windows* (~100MB)
    1. Install it manually from download folder, if you had opted for download option
1. Install Visual Studio 2013
1. Install [Win32 OpenSSL `1.0.1` Light](https://slproweb.com/products/Win32OpenSSL.html) into Windows System folders
1. Install [Zeal Documentation Explorer](https://zealdocs.org/
)
    1. Download Qt5 documentation
    1. Download C++ documentation
1. Install [AutoHotKey](https://autohotkey.com/)
1. Install [7-Zip](http://www.7-zip.org/download.html)
1. Install [Slack](https://slack.com/downloads)
1. Install Chocolatey Packages
	1. Install [Chocolatey](https://chocolatey.org/install)
    1. Install [Ag - The Silver Searcher](https://github.com/ggreer/the_silver_searcher/wiki/Windows)
1. Install [Python2 and Python3](https://www.python.org/downloads/windows/)
1. Install [Ruby](https://rubyinstaller.org/)
1. [Visual Studio Code](https://code.visualstudio.com/)
	1. Install [Visual Studio Code Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)
    1. Download Visual Studio Code settings
1. Install [Inconsolata fonts](https://github.com/google/fonts/tree/master/ofl/inconsolata)
1. Install [Evernote](https://evernote.com/download/get.php?file=Win)
1. Install [CopyQ Clipboard Manager](https://hluk.github.io/CopyQ/)
1. Install [Don't Sleep Utility](http://www.softwareok.com/?Download=DontSleep)
    1. Alternate is [Caffeinated](http://desmondbrand.com/caffeinated/) but it requires .Net 3.5
    1. Another alternate is [Caffeine](http://www.zhornsoftware.co.uk/caffeine/) but it [keeps inserting `<F15>` in Vim](http://vi.stackexchange.com/questions/3342/using-vim-and-caffeine-on-the-same-machine)
    1. Set options in Don't Sleep to Start Minimized and Start with Windows

## Download Applications

Create a folder `bin` in `%HOMEPATH%`, using `mkdir %HOMEPATH%\bin` command. This folder is referred to as `bin`, henceforth.

Download following apps and extract them in `bin` folder, and add their path to `%PATH%` variable.

To edit `%PATH%` variable, open Environment Variables using `rundll32.exe shell32.dll,Control_RunDLL sysdm.cpl,,3`.

1. [Vim](https://tuxproject.de/projects/vim/)
1. [Lua](http://luabinaries.sourceforge.net/)
	1. Navigate and download from `Windows Libraries/Dynamic` folder

You can check path of each command using `where` command. For example,

```
> where gvim
C:\Users\talha\bin\complete-x64\gvim.exe
```

You can use it to test each downloaded program is available from `%PATH%`.

## Configure

### Map Keys

Use SharpKeys to,

1. Map Caps Lock to Left Ctrl key
1. Map Left Ctrl to Left Win key
1. Map Left Win to Right Ctrl key

### Track Pad

To invert the direction of scrolling (natural scrolling on macOS), run following command in PowerShell with administrative privileges.

```powershell
Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Enum\HID\*\*\Device` Parameters FlipFlopWheel -EA 0 | ForEach-Object { Set-ItemProperty $_.PSPath FlipFlopWheel 1 }
Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Enum\HID\*\*\Device` Parameters FlipFlopHScroll  -EA 0 | ForEach-Object { Set-ItemProperty $_.PSPath FlipFlopHScroll 1 }

```

See [SuperUser answer](http://superuser.com/a/364353/42415) for details.

Natural direction of scrolling is how you scroll on iPhone, Android and other touch devices. Content scrolls in the direction of your fingers.

### Mouse Properties

Open mouse properties using `control main.cpl`.

1. In *Buttons* tab, turn on *ClickLock*
	1. In *Settings*, set duration to the shortest possible
2. In *Pointer Options* tab, enable *Show Location of Pointer*
3. In *Wheel* tab, change scroll speed to 1

## Dotfiles

Create a `Repos` directory in `%HOMEPATH%`. Clone [dotfiles repository](https://github.com/talha131/dotfiles).

### Git

Start a `cmd` tab with administrative privilege in ConEmu. Create symbolic links thusly,

```
mklink %HOMEPATH%\.gitconfig %HOMEPATH%\Repos\dotfiles\git\gitconfig
mklink %HOMEPATH%\.githelper %HOMEPATH%\Repos\dotfiles\git\githelper
mklink %HOMEPATH%\bin\diff-highlight %HOMEPATH%\Repos\dotfiles\bin\diff-highlight
```

### Vim

Open Vim and check you have Python2, Python3, Ruby, and Lua working, using following commands,

```
:echo has('python3')
:echo has('python')
:echo has('ruby')
:echo has('lua')
```

#### Link to Vim Configuration

Start `cmd` with administrative privilege in ConEmu. Create symbolic links thusly,

```
mklink %HOMEPATH%\.vimrc %HOMEPATH%\Repos\dotfiles\vim\vimrc
mklink /d %HOMEPATH%\.vim\ %HOMEPATH%\Repos\dotfiles\vim\vim\
```

#### Install Vim-Plug

Open Powershell and type these commands

```powershell
md ~\.vim\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\.vim\autoload\plug.vim"))
```

#### Install Plugins

Open Vim, ignore errors and issue `:PlugInstall!` to install all plugins and themes.

Restart Vim. This time there should be no errors.

#### Diff

It is possible that diff or Gdiff (in Vim Fugitive) will not work. Tuxproject Vim does not include a `diff.exe`.

Check output of

```
:!where diff
```

If the result is empty or Gdiff is not working then add `diff.exe` from Git installation to your `%PATH%`.

Open your Environment Variables, edit `%PATH%` to add `C:\Program Files\Git\usr\bin`.

See this [Github issue](https://github.com/tpope/vim-fugitive/issues/680#issuecomment-134650380) for details.

#### Add gVim to Context Menu

I am using portable version of Vim from Tuxproject which does not come with an installer. It does not get added to the Windows context automatically.

To add gVim to context menu, open registry `regedit`.

1. Navigate to `HKEY_CLASSES_ROOT\*\shell`.
1. Add new key under it `gVim`.
1. Change value of `Default` to `Open with gVim`
1. Add a new string value, named `Icon`. Set it's value to gVim executable, in this case `"C:\Users\talha\bin\complete-x64\gvim.exe"`
1. Add a new sub key under `gVim`. Name it `command`
1. Set `command`'s default value to gVim executable, in this case `"C:\Users\talha\bin\complete-x64\gvim.exe" "%1"`

See [this link](http://superuser.com/a/37923/42415) for details.

### AutoHotKey

To auto start the AutoHotKey script every time windows starts. Start `cmd` with administrative privilege in ConEmu. Create symbolic links thusly,

```
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\init.ahk" %HOMEPATH%\Repos\dotfiles\autohotkey\init.ahk
```

### Install AutoJump

You must have Clink installed before you install AutoJump

1. Clone [AutoJump](https://github.com/wting/autojump)
1. Add [patch](https://github.com/wting/autojump/issues/436)
1. Open `cmd`
1. Make sure Clink is working in `cmd`
1. Switch to AutoJump directory
1. Install AutoJump using `python install.py`
1. Successful installation will output a path, add this path your `%PATH%`.

### Clink

You can view Clink settings and configuration directory using `clink set` command.

## Color Codes

To have [Gruvbox](https://github.com/morhetz/gruvbox) dark theme like background in `cmd` or Git shell, use following color codes:

|   Color Values    | Red | Green | Blue |
|        ---        | --- |  ---  | ---  |
| Screen Background | 44  |  44   |  44  |
|    Screen Text    | 218 |  198  | 144  |

# Outdated Content

I need to review and update following portion of this file.

Overview of my dotfiles
-----------------------

These configuration files do not work out of the box. These are specific to my Mac OSX system.

Following are my not so comprehensive and perhaps out of date notes.

Git
---

1.  [David DeSandro](http://dropshado.ws/post/7844857440/gitconfig-colors) blog entry is a good start point.
2.  [Cheat sheets](http://cheat.errtheblog.com/s/git) has more comprehensive entry.

Vim
---

1.  [Vrome](https://chrome.google.com/webstore/detail/godjoomfiimiddapohpmfklhgmbfffjj) is a Google Chrome extension.

### Auto Close

1.  [SO thread](http://stackoverflow.com/q/883437/177116) has got some good comments.
1.  I decided to use Thiago Alves/Townk's [plugin](https://github.com/Townk/vim-autoclose).
1.  [Townk's plugin tutorial](http://www.vim.org/scripts/script.php?script_id=2009).

### Vim Markdown

1.  [tpope/vim-markdown](https://github.com/tpope/vim-markdown) is mostly used. But it does not conceal text markers in Markdown file.
2.  [xolox/vim-markdown](https://github.com/xolox/vim-markdown) does the concealing. See [this image](https://github.com/tpope/vim-markdown/pull/9#issuecomment-3098050) for example.
3.  But you have to switch to xolox/vim-markdown `conceal` branch to get his code. Use `git checkout -b conceal remotes/origin/conceal` to
    checkout the branch.

### Fuzzy File Finder

1.  I tried [command-t](https://wincent.com/products/command-t/) but I could not make it work. It requires that your copy of Vim should be compiled with the same version of ruby with which you compiled command-t, which effectively means you have to compile Vim yourself.
2.  I took the easier way, use [CtrlP](http://kien.github.com/ctrlp.vim/). It is basically the same as Command-T but written in pure Vimscript. This means it neither requires Ruby support enabled in Vim nor does it require the compilation of some Ruby extension implemented in C.
3.  Other extensions are either not what I wanted, for example, [LustyJuggler](http://www.vim.org/scripts/script.php?script_id%3D2050), or not actively maintained any more like [FuzzyFinder](http://www.vim.org/scripts/script.php?script_id%3D1984) and [fuzzy file finder](https://github.com/jamis/fuzzy_file_finder).

Bash
----

1.  Bash completion depends on bash\_completion package. MacPorts users can do `sudo port install git-core +bash_completion`.
2.  [Git Utilities You Can't Live Without](http://blog.bitfluent.com/post/27983389/git-utilities-you-cant-live-without) blog entry has an entry for Git aware PS1.
