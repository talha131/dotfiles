function up -d "Update software to the latest versions"

    if contains "brew" $argv or contains "nvim" $argv
        _updateBrew

        if contains "brew" $argv
            _updateBrewPackages
        end
        if contains "nvim" $argv
            _updateNeoVim
        end
    end

    if contains "pip" $argv
        _updatePipPackages
        _updatePyenvShims
    end

    if contains "gem" $argv
        _updateGems
        _updateRbenvShims
    end

    if contains "vim" $argv
        _updateVimPlugins
    end

    if contains "npm" $argv
        _updateNpmPackages
    end

    if contains "fish" $argv
        _updateFishCompletions
    end

    set i (count $argv)
    if contains "all" $argv; or math "$i == 0" > /dev/null
        echo "Update all packages. Except NeoVim"
        # _updateBrew
        # _updateBrewPackages
        # _updatePipPackages
        # _updatePyenvShims
        # _updateGems
        # _updateRbenvShims
        # _updateVimPlugins
        # _updateNpmPackages
        # _updateFishCompletions
    end
end

complete -c up -a "all brew fish gem npm nvim pip vim"

function _printMessage
    for arg in $argv
        set_color -o yellow; echo "📌  "$arg
    end
    set_color normal
end

function _updateBrew
    which brew >/dev/null
    and begin
        echo "Updating Brew"
        brew update
    end
    functions -e _updateBrew
end

function _updateBrewPackages
    which brew >/dev/null
    and begin
        echo "Upgrading Brew"
        brew upgrade --all
        brew linkapps
        echo "Cleanup Brew"
        brew cleanup
        brew cask cleanup
    end
    functions -e _updateBrewPackages
end

function _updateNeoVim
    which brew >/dev/null
        and begin
        echo "Updating NeoVim"
        brew reinstall --HEAD neovim
    end
    functions -e _updateNeoVim
end

function _updatePipPackages
    which pip > /dev/null
    and begin
        echo "Updating pip"
        pip install --upgrade pip
        echo "Updating pip packages"
        pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
    end
    functions -e _updatePip
end

function _updateGems
    which gem > /dev/null
    and begin
        echo "Updating gems"
        gem update (eval gem outdated | cut -d ' ' -f 1)
        echo "Cleaning up old versions of Gem"
        gem cleanup
    end
    functions -e _updateGems
end

function _updateRbenvShims
    which rbenv > /dev/null
    and begin
        echo "Rebuild rbenv shim"
        rbenv rehash
    end
    functions -e _updateRbenvShims
end

function _updatePyenvShims
    which pyenv > /dev/null
    and begin
        echo "Rebuild pyenv shim binaries"
        pyenv rehash
    end
    functions -e _updatePyenvShims
end

function _updateVimPlugins
    which vim > /dev/null
    and begin
        echo "Update Vim Plugins"
        vim -i NONE -c PlugUpgrade -c PlugUpdate -c PlugClean! -c quitall
    end
    functions -e _updateVimPlugins
end

function _updateNpmPackages
    which npm > /dev/null
    and begin
        echo "Update NPM global packages"
        npm outdated -g
        npm update -g
        npm outdated -g
    end
    functions -e _updateNpmPackages
end

function _updateFishCompletions
    echo "Updating completions"
    fish_update_completions
    functions -e _updateFishCompletions
end

