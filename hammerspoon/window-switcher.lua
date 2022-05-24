-- from https://www.hammerspoon.org/docs/hs.window.switcher.html
-- set up your windowfilter
switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
switcher_browsers = hs.window.switcher.new{'Safari','Google Chrome'} -- specialized switcher for your dozens of browser windows :)

local switch = switcher_space

-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind('alt','tab','Next window',function() switch:next() end)
hs.hotkey.bind('alt-shift','tab','Prev window',function() switch:previous() end)

