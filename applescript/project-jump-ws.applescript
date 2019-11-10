tell application "iTerm"
    activate

    tell current window
        create tab with default profile

        tell current session of current tab
            split vertically with default profile
            split vertically with default profile
            split vertically with default profile
            split vertically with default profile
        end tell

        -- Push out code periodically
        tell first session of current tab
            write text "cd ~/Repos/jump-ws/"
            write text "tm_git_push"
        end tell

        -- Neuron code
        tell second session of current tab
            write text "cd ~/Repos/jump-ws/neuron"
            select
            tell application "System Events"
                keystroke "nvim -S ~/.vim/sessions/neuron"
                delay 1	
            end tell
        end tell

        -- Front-end code
        tell fourth session of current tab
            write text "cd ~/Repos/jump-ws/neuron-frontend"
            select
            tell application "System Events"
                keystroke "nvim -S ~/.vim/sessions/neuron-frontend"
                delay 1	
            end tell
        end tell

        -- Font-end dev
        tell fifth session of current tab
            write text "cd ~/Repos/jump-ws/neuron-frontend"
            write text "yarn install"
            write text "yarn start"
        end tell

        -- Neuron server
        tell third session of current tab
            write text "cd ~/Repos/jump-ws/neuron"
            write text "make && neuron -test --logformat text"
            select
            tell application "System Events"
                keystroke return using command down
            end tell
        end tell

    end tell

end tell
