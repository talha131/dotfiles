tell application "iTerm"
	activate
	tell current window
		create tab with default profile
		
		tell current session of current tab
			split vertically with default profile
			split vertically with default profile
			split vertically with default profile
			split vertically with default profile
			split vertically with default profile
			split vertically with default profile
		end tell
		
		tell first session of current tab
			write text "cd ~/Repos/admissiontest/nexus"
		end tell
		
		tell second session of current tab
			write text "cd ~/Repos/admissiontest/nexus"
            write text "make start"
		end tell

		tell third session of current tab
			write text "cd ~/Repos/admissiontest/"
		end tell

		tell fourth session of current tab
			write text "cd ~/Repos/admissiontest/frontend"
		end tell

		tell fifth session of current tab
			write text "cd ~/Repos/admissiontest/frontend"
            write text "yarn install && yarn start"
		end tell

		tell sixth session of current tab
			write text "cd ~/Repos/admissiontest/database"
		end tell

		tell seventh session of current tab
			write text "cd ~/Repos/admissiontest/database"
            write text "psql postgresql://localhost:5432/admissiontest"
		end tell
		
	end tell
end tell
