-- --------------------------------------------------------
-- Helper functions - these do all the heavy lifting below.
-- Names are roughly stolen from same functions in Slate :)
-- Based on https://github.com/exark/dotfiles/blob/master/.hammerspoon/init.lua
-- --------------------------------------------------------

-- Move a window a number of pixels in x and y
function nudge(xpos, ypos)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.x = f.x + xpos
	f.y = f.y + ypos
	win:setFrame(f)
end

-- Resize a window by moving the bottom
function yank(xpixels,ypixels)
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.w = f.w + xpixels
	f.h = f.h + ypixels
	win:setFrame(f)
end

-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function push(x, y, w, h)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w*x)
	f.y = max.y + (max.h*y)
	f.w = max.w*w
	f.h = max.h*h
	win:setFrame(f)
end

function fullScreen()
	local win = hs.window.focusedWindow()
    win:setFullScreen(not win:isFullScreen())
end
-- End of Helper Functions

local modalKey = hs.hotkey.modal.new(hyper, 'W', 'Window Management mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

hs.window.animationDuration = 0

modalKey:bind('', 'N', 'Move window to next monitor screen' , hs.grid.pushWindowNextScreen, function() modalKey:exit() end)

modalKey:bind('', 'left', 'Resize window to left half', function() push(0, 0, 0.5, 1) end, function() modalKey:exit() end)
modalKey:bind('', 'down', 'Resize window to bottom half', function() push(0, 0.5, 1, 0.5) end, function() modalKey:exit() end)
modalKey:bind('', 'up', 'Resize window to top half', function() push(0, 0, 1, 0.5) end, function() modalKey:exit() end)
modalKey:bind('', 'right', 'Resize window to right', function() push(0.5, 0, 0.5, 1) end, function() modalKey:exit() end)

modalKey:bind('', 'Q', 'Resize window to half of screen, center vertically', function() push(0, 0.25, 1, 0.5) end, function() modalKey:exit() end)
modalKey:bind('', 'W', 'Resize window to half of screen, center horizontally', function() push(0.25, 0, 0.5, 1) end, function() modalKey:exit() end)
modalKey:bind('', 'E', 'Resize window to quarter of screen, center vertically, align to left', function() push(0, 0.25, 0.5, 0.5) end, function() modalKey:exit() end)
modalKey:bind('', 'R', 'Resize window to quarter of screen, center vertically, align to right', function() push(0.5, 0.25, 0.5, 0.5) end, function() modalKey:exit() end)
modalKey:bind('', 'T', 'Resize window to quarter of screen, center horizontally, align to top', function() push(0.25, 0, 0.5, 0.5) end, function() modalKey:exit() end)
modalKey:bind('', 'Y', 'Resize window to quarter of screen, center horizontally, align to bottom', function() push(0.25, 0.5, 0.5, 0.5) end, function() modalKey:exit() end)

modalKey:bind('', 'H', 'Resize window to top left', function() push(0, 0, 0.5, 0.5) end, function() modalKey:exit() end)
modalKey:bind('', 'J', 'Resize window to top right', function() push(0.5, 0, 0.5, 0.5) end, function() modalKey:exit() end)
modalKey:bind('', 'K', 'Resize window to bottom left', function() push(0, 0.5, 0.5, 0.5) end, function() modalKey:exit() end)
modalKey:bind('', 'L', 'Resize window to bottom right', function() push(0.5, 0.5, 0.5, 0.5) end, function() modalKey:exit() end)

modalKey:bind('', 'C', 'Resize window to center', function() push(0.15, 0.15, 0.7, 0.7) end, function() modalKey:exit() end)
modalKey:bind('', 'F', 'Toggle full screen', function() fullScreen() end, function() modalKey:exit() end)
modalKey:bind('', 'M', 'Maximize window', hs.grid.maximizeWindow, function() modalKey:exit() end)

local positionDelta = 50
modalKey:bind('alt', 'left', 'Move window to left', function() nudge(-positionDelta, 0) end)
modalKey:bind('alt', 'down', 'Move window down', function() nudge(0, positionDelta) end)
modalKey:bind('alt', 'up', 'Move window up', function() nudge(0, -positionDelta) end)
modalKey:bind('alt', 'right', 'Move window to right', function() nudge(positionDelta, 0) end)

local sizeDelta = 50
modalKey:bind('', '=', 'Increase window height', function() yank(0, sizeDelta) end)
modalKey:bind('', '-', 'Decrease window height', function() yank(0, -sizeDelta) end)
modalKey:bind('', ']', 'Increase window width', function() yank(sizeDelta, 0) end)
modalKey:bind('', '[', 'Decrease window width', function() yank(-sizeDelta, 0) end)

-- Grid Management

hs.grid.setGrid('10x4')
hs.grid.ui.textSize = 150

modalKey:bind('', 'G', 'Show Grid', function() hs.grid.show(function() modalKey:exit() end) end)
modalKey:bind('', 'S', 'Snap active window to grid', function() hs.grid.snap(hs.window.focusedWindow()) end, function() modalKey:exit() end)

