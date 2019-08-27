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
			write text "cd ~/Repos/onCrashReboot"
			write text "vf activate elegant-4"
			write text "gulp"
		end tell
		
		-- split for running nvim
		tell second session of current tab
			write text "cd ~/Repos/onCrashReboot"
			write text "nvim -S ~/.vim/sessions/onCrashReboot"
			select
		end tell
		
		-- for any other task		
		tell third session of current tab
			write text "cd ~/Repos/onCrashReboot"
		end tell
		
	end tell
end tell
