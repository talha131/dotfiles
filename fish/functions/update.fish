function update -d 'Update software to the latest versions'

    function _printMessage
        for arg in $argv
            set_color -o yellow
            echo '📌  '$arg
        end
        set_color normal
    end

    function _updateBrew
        which brew >/dev/null
        and begin
            _printMessage 'Updating Brew'
            brew update
        end
        functions -e _updateBrew
    end

    function _updateBrewPackages
        which brew >/dev/null
        and begin
            _printMessage 'Upgrading Brew'
            brew upgrade
            _printMessage 'Cleaning up Brew'
            brew cleanup
            brew cask cleanup
        end
        functions -e _updateBrewPackages
    end

    function _updateNeovim
        which brew >/dev/null
            and begin
            _printMessage 'Updating Neovim'
            brew reinstall --HEAD neovim
        end
        functions -e _updateNeovim
    end

    function _updatePipPackages
        which pip > /dev/null
        and begin
            _printMessage 'Updating pip'
            pip install --upgrade pip
            _printMessage 'Updating pip packages'
            pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
        end
        functions -e _updatePip
    end

    function _updateGems
        which gem > /dev/null
        and begin
            _printMessage 'Updating gems'
            gem update (eval gem outdated | cut -d ' ' -f 1)
            _printMessage 'Cleaning up old versions of Gem'
            gem cleanup
        end
        functions -e _updateGems
    end

    function _updateRbenvShims
        which rbenv > /dev/null
        and begin
            _printMessage 'Rebuilding rbenv shims'
            rbenv rehash
        end
        functions -e _updateRbenvShims
    end

    function _updatePyenvShims
        which pyenv > /dev/null
        and begin
            _printMessage 'Rebuilding pyenv shims'
            pyenv rehash
        end
        functions -e _updatePyenvShims
    end

    function _updateVimPlugins
        which vim > /dev/null
        and begin
            _printMessage 'Updating Vim Plugins'
            vim -i NONE -c PlugUpgrade -c PlugUpdate -c PlugClean! -c quitall
        end
        functions -e _updateVimPlugins
    end

    function _updateNpmPackages
        which npm > /dev/null
        and begin
            _printMessage 'Updating global NPM packages'
            npm outdated -g
            npm update -g
            npm outdated -g
        end
        functions -e _updateNpmPackages
    end

    function _updateFishCompletions
        _printMessage 'Updating completions'
        fish_update_completions
        functions -e _updateFishCompletions
    end

    # Main method starts from here
    set argument all brew fish gem npm nvim pip vim
    set validArgument 'false'

    if contains $argument[2] $argv; or contains $argument[6] $argv
        set validArgument 'true'
        _updateBrew

        if contains $argument[2] $argv
            _updateBrewPackages
        end
        if contains $argument[6] $argv
            _updateNeovim
        end
    end

    if contains $argument[7] $argv
        set validArgument 'true'
        _updatePipPackages
        _updatePyenvShims
    end

    if contains $argument[4] $argv
        set validArgument 'true'
        _updateGems
        _updateRbenvShims
    end

    if contains $argument[8] $argv
        set validArgument 'true'
        _updateVimPlugins
    end

    if contains $argument[5] $argv
        set validArgument 'true'
        _updateNpmPackages
    end

    if contains $argument[3] $argv
        set validArgument 'true'
        _updateFishCompletions
    end

    set i (count $argv)
    if contains $argument[1] $argv; or math "$i == 0" > /dev/null
        set validArgument 'true'
        _printMessage 'Update all packages. Except Neovim'
        _updateBrew
        _updateBrewPackages
        _updatePipPackages
        _updatePyenvShims
        _updateGems
        _updateRbenvShims
        _updateVimPlugins
        _updateNpmPackages
        _updateFishCompletions
    end

    if [ $validArgument = 'false' ]
        set_color -o red
        echo '⚠️  Incorrent argument. Valid values are'
        echo
        echo '🚩  '$argument
        set_color normal
    end

end

complete --no-files -c update -a all  -d 'Update all packages. Except Neovim'
complete --no-files -c update -a brew -d 'Update brew, upgrade and cleanup installed packages'
complete --no-files -c update -a fish -d 'Update fish completions'
complete --no-files -c update -a gem  -d 'Update and cleanup installed gems. Update rbenv shims'
complete --no-files -c update -a npm  -d 'Update global npm packages'
complete --no-files -c update -a nvim -d 'Install Neovim from HEAD of its git repository'
complete --no-files -c update -a pip  -d 'Update pip and installed packages. Update pyenv shims'
complete --no-files -c update -a vim  -d 'Update and clean up Vim plugins. Requires vim-plug'

