tell application "iTerm"
	activate
	tell current window
		create tab with default profile
		
		tell current session of current tab
			split vertically with default profile
			split vertically with default profile
		end tell
		
		-- split for running gulp
		tell first session of current tab
			write text "cd ~/Repos/elegant"
			write text "vf activate elegant-4"
			write text "gulp"
		end tell
		
		-- split for running nvim
		tell second session of current tab
			write text "cd ~/Repos/elegant"
			write text "vf activate elegant-4"
			select
            tell application "System Events"
                keystroke "nvim -S ~/.vim/sessions/elegant"
            end tell
		end tell
		
		-- for any other task		
		tell third session of current tab
			write text "cd ~/Repos/elegant"
			write text "vf activate elegant-4"
		end tell
		
	end tell
end tell

tell application "System Events"
	keystroke return using command down
end tell

