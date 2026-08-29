# Editor (used by git, crontab, kubectl, and other tools)
set -gx EDITOR nvim

# vcpkg (C++ package manager)
set -gx VCPKG_ROOT $HOME/vcpkg

# Personal scripts
fish_add_path ~/Developer/dotfiles/bin

# Load API Keys
# Create ~/.secrets.fish with: set -x GEMINI_API_KEY "your-key"
# Secure it with: chmod 600 ~/.secrets.fish (owner read/write only)
test -e ~/.secrets.fish && source ~/.secrets.fish

# coreutils (use GNU commands without g prefix)
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin

# less (enable ANSI color rendering)
set -gx LESS '-R'

# bat as man pager (colored man pages)
# "bat -plman" messes up the man page formatting
command -q bat && set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Setting fd as the default source for fzf
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix'
# Ctrl-T for directory navigation
set -gx FZF_CTRL_T_COMMAND 'fd --type d --strip-cwd-prefix'
set -gx FZF_CTRL_T_OPTS "--preview 'ls -la {}' --height=100%"
# Alt-C for file search
set -gx FZF_ALT_C_COMMAND 'fd --type f --strip-cwd-prefix'
set -gx FZF_ALT_C_OPTS "--preview 'bat --style=numbers --color=always --line-range :500 {}' --height=100%"

if status is-interactive
    # Starship prompt
    starship init fish | source

    # iTerm2 integration
    test -e {$HOME}/.iterm2_shell_integration.fish && source {$HOME}/.iterm2_shell_integration.fish

    # Zoxide (replaces autojump)
    zoxide init --cmd j fish | source

    # fzf key bindings
    fzf --fish | source

    # Abbreviations
    abbr -a trash 'trash -v'  # Verbose trash output
    # Download highest-quality audio from YouTube/etc. via yt-dlp.
    # Outputs <video-title>.opus (or native best codec) in CWD.
    # Usage: ytaudio <url> [more-urls...]
    abbr -a ytaudio 'yt-dlp -x --audio-format best --audio-quality 0 -o "%(title)s.%(ext)s"'
    abbr -a claude 'claude --dangerously-skip-permissions'
end
# Added by Antigravity
fish_add_path ~/.antigravity/antigravity/bin

# uv
fish_add_path ~/.local/bin

# Trust workspaces for Gemini CLI so headless dispatches (e.g. /octo:review)
# don't bail with the trusted-folders prompt. Required for the Octopus
# multi-LLM review fleet to actually use Gemini instead of falling back.
set -gx GEMINI_CLI_TRUST_WORKSPACE true

# Firebase Admin SDK service-account credentials, consumed by tooling that
# talks to Firebase (e.g. the Admin SDK). Point at the local key file.
set -gx FIREBASE_ADMIN_KEY ~/.config/firebase/admin.json

# Java for Android/Gradle builds. AGP 9.x + Gradle 9.x are validated on JDK 21,
# which is also what the Android CI job uses; the unversioned openjdk is newer
# and is not. Every Homebrew openjdk is keg-only, so nothing is linked into
# /opt/homebrew/bin: point JAVA_HOME at 21 explicitly and put its bin ahead of
# the /opt/homebrew/opt/openjdk/bin entry already in fish_user_paths.
# Keg-only JDKs are invisible to /usr/libexec/java_home, which sees only
# Temurin and silently returns it for any -v N. Reach the others by full path:
# /opt/homebrew/opt/openjdk@N/libexec/openjdk.jdk/Contents/Home
set -gx JAVA_HOME /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
fish_add_path $JAVA_HOME/bin

# Android SDK. One SDK root, the location Android Studio also defaults to, so
# the IDE and command-line Gradle builds share the same packages. platform-tools
# goes ahead of /opt/homebrew/bin because the android-platform-tools cask
# symlinks its own adb/fastboot there; keeping the SDK copy first means adb
# tracks whatever Studio installs instead of drifting on a separate release
# cadence. sdkmanager/avdmanager live only under cmdline-tools/latest/bin --
# Homebrew ships no copy of those, so nothing shadows them.
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx ANDROID_SDK_ROOT $ANDROID_HOME
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin
