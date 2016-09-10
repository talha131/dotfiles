function up -d "Update software to the latest versions"

    which brew >/dev/null
    and begin
        echo "Updating Brew"
        brew update 
        echo "Upgrading Brew"
        brew reinstall --HEAD neovim
        brew upgrade --all
        echo "Cleanup Brew"
        brew linkapps --local
        brew cleanup
        brew cask cleanup
    end

    which pip > /dev/null
    and begin
        echo "Updating pip"
        pip install --upgrade pip
        echo "Updating pip packages"
        pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
    end

    which gem > /dev/null
    and begin
        echo "Updating gems"
        gem update (eval gem outdated | cut -d ' ' -f 1)
        echo "Cleaning up old versions of Gem"
        brew cleanup
    end

    which pyenv > /dev/null
    and begin
        echo "Rebuild pyenv shim binaries"
        pyenv rehash
    end

    which pyenv > /dev/null
    and begin
        echo "Update Vim Plugins"
        vim -i NONE -c VundleUpdate -c quitall
    end

    which npm > /dev/null
    and begin
        echo "Update NPM global packages"
        npm outdated -g
        npm update -g
        npm outdated -g
    end

    echo "Updating completions"
    fish_update_completions

end

