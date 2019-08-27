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
		
		tell first session of current tab
			write text "cd ~/Repos/jump-ws/neuron"
			write text "make && neuron -test --logformat text"
		end tell
		
		tell second session of current tab
			write text "cd ~/Repos/jump-ws/neuron"
			select
		end tell
		
		tell third session of current tab
			write text "cd ~/Repos/jump-ws/neuron-frontend"
			write text "yarn install"
			write text "yarn start"
		end tell
		
		tell fourth session of current tab
			write text "cd ~/Repos/jump-ws/neuron-frontend"
		end tell
		
		tell fifth session of current tab
			write text "cd ~/Repos/jump-ws/"
			write text "tm_git_push"
		end tell
		
	end tell
	
end tell

tell application "System Events"
	keystroke return using command down
end tell
