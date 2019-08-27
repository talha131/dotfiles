tell application "iterm"
	activate
	tell current window
		create tab with default profile
		
		tell current session of current tab
			split vertically with default profile
			split vertically with default profile
		end tell
		
		-- split for running gulp
		tell first session of current tab
			write text "cd"
			write text "tiddlysave"
			write text "tiddlyserver"
		end tell
		
		-- monitor network status
		tell second session of current tab
			write text "cd"
			write text "ping www.google.com --apple-time"
		end tell
		
		-- for any other task		
		tell third session of current tab
			write text "cd"
			select
		end tell
		
	end tell
end tell

