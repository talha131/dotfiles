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
            _printMessage 'Upgrading Brew'
            brew upgrade
            _printMessage 'Cleaning up Brew'
            brew cleanup
        end
        functions -e _updateBrew
    end

    function _updatePipPackages
        which pip3 > /dev/null
        and begin
            _printMessage 'Updating pip3'
            pip3 install --upgrade pip
            _printMessage 'Updating pip3 packages'
            pip3 list --outdated --format=json | python3 -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))" | xargs pip3 install -U
        end
        functions -e _updatePip
    end

    function _updateGems
        which gem > /dev/null
        and begin
            _printMessage 'Updating gems'
            gem update --user-install (eval gem outdated | cut -d ' ' -f 1)
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
            nvim -i NONE -c PlugUpgrade -c PlugUpdate -c PlugClean! -c quitall
        end
        functions -e _updateVimPlugins
    end

    function _updateNpmPackages
        which npm > /dev/null
        and begin
            _printMessage 'Updating global NPM packages'
            npm update -g
        end
        functions -e _updateNpmPackages
    end

    function _updateFishCompletions
        _printMessage 'Updating fish completions'
        fish_update_completions
        functions -e _updateFishCompletions
    end

    # Main method starts from here
    set argument all brew fish gem npm pip vim
    set validArgument 'false'

    set i (count $argv)
    if contains $argument[1] $argv; or test $i -eq 0
        set validArgument 'true'
        _printMessage 'Update all packages'
        _updateBrew
        _updatePipPackages
        _updatePyenvShims
        _updateGems
        _updateRbenvShims
        _updateVimPlugins
        _updateNpmPackages
        _updateFishCompletions
    end

    if contains $argument[2] $argv 
        set validArgument 'true'
        _updateBrew
    end

    if contains $argument[3] $argv
        set validArgument 'true'
        _updateFishCompletions
    end

    if contains $argument[4] $argv
        set validArgument 'true'
        _updateGems
        _updateRbenvShims
    end

    if contains $argument[5] $argv
        set validArgument 'true'
        _updateNpmPackages
    end

    if contains $argument[6] $argv
        set validArgument 'true'
        _updatePipPackages
        _updatePyenvShims
    end

    if contains $argument[7] $argv
        set validArgument 'true'
        _updateVimPlugins
    end

    if [ $validArgument = 'false' ]
        set_color -o red
        echo '⚠️  Incorrent argument. Valid values are'
        echo
        echo '🚩  '$argument
        set_color normal
    end

end

complete --no-files -c update -a all  -d 'Update all packages'
complete --no-files -c update -a brew -d 'Update brew, upgrade, casks, and cleanup installed packages'
complete --no-files -c update -a fish -d 'Update fish completions'
complete --no-files -c update -a gem  -d 'Update and cleanup installed gems. Update rbenv shims'
complete --no-files -c update -a npm  -d 'Update global npm packages. Requires yarn'
complete --no-files -c update -a pip  -d 'Update pip and installed packages. Update pyenv shims'
complete --no-files -c update -a vim  -d 'Update and clean up Neovim plugins. Requires vim-plug'
