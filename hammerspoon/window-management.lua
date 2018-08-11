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
function modalKey:exited()
    hs.alert.show('Window Management mode exited', 1)
end

hs.window.animationDuration = 0

modalKey:bind('', 'N', 'Move window to next monitor screen' , hs.grid.pushWindowNextScreen)

modalKey:bind('', 'left', 'Resize window to left half', function() push(0, 0, 0.5, 1) end)
modalKey:bind('', 'down', 'Resize window to bottom half', function() push(0, 0.5, 1, 0.5) end)
modalKey:bind('', 'up', 'Resize window to top half', function() push(0, 0, 1, 0.5) end)
modalKey:bind('', 'right', 'Resize window to right', function() push(0.5, 0, 0.5, 1) end)

modalKey:bind('', 'Q', 'Resize window to half of screen, center vertically', function() push(0, 0.25, 1, 0.5) end)
modalKey:bind('', 'W', 'Resize window to half of screen, center horizontally', function() push(0.25, 0, 0.5, 1) end)
modalKey:bind('', 'E', 'Resize window to quarter of screen, center vertically, align to left', function() push(0, 0.25, 0.5, 0.5) end)
modalKey:bind('', 'R', 'Resize window to quarter of screen, center vertically, align to right', function() push(0.5, 0.25, 0.5, 0.5) end)
modalKey:bind('', 'T', 'Resize window to quarter of screen, center horizontally, align to top', function() push(0.25, 0, 0.5, 0.5) end)
modalKey:bind('', 'Y', 'Resize window to quarter of screen, center horizontally, align to bottom', function() push(0.25, 0.5, 0.5, 0.5) end)

modalKey:bind('', 'I', 'Resize window to top left quarter of screen', function() push(0, 0, 0.5, 0.5) end)
modalKey:bind('', 'O', 'Resize window to top right quarter of screen', function() push(0.5, 0, 0.5, 0.5) end)
modalKey:bind('', 'U', 'Resize window to bottom left quarter of screen', function() push(0, 0.5, 0.5, 0.5) end)
modalKey:bind('', 'P', 'Resize window to bottom right quarter of screen', function() push(0.5, 0.5, 0.5, 0.5) end)

modalKey:bind('', 'C', 'Resize window to center', function() push(0.15, 0.15, 0.7, 0.7) end)
modalKey:bind('', 'F', 'Toggle full screen', function() fullScreen() end)
modalKey:bind('', 'M', 'Maximize window', hs.grid.maximizeWindow)

local positionDelta = 100
modalKey:bind('shift', 'left', 'Move window to left', function() nudge(-positionDelta, 0) end)
modalKey:bind('shift', 'down', 'Move window down', function() nudge(0, positionDelta) end)
modalKey:bind('shift', 'up', 'Move window up', function() nudge(0, -positionDelta) end)
modalKey:bind('shift', 'right', 'Move window to right', function() nudge(positionDelta, 0) end)

local sizeDelta = 50
modalKey:bind('', '=', 'Increase window height', function() yank(0, sizeDelta) end)
modalKey:bind('', '-', 'Decrease window height', function() yank(0, -sizeDelta) end)
modalKey:bind('', ']', 'Increase window width', function() yank(sizeDelta, 0) end)
modalKey:bind('', '[', 'Decrease window width', function() yank(-sizeDelta, 0) end)

-- Grid Management

-- Grid columns should be equal to number of hints in each row. Default hints variable is an array of 5x10
-- If grid columns and hint columns do not match, the Hammerspoon merges cells such that they total number
-- columns in the grid remains 10.
-- For details see https://github.com/Hammerspoon/hammerspoon/issues/1619
-- Here I don't expect to use column 2-5 much so I have set their hints to hard to access keys.
-- If need arises I can simply use arrow keys to select those cells instead of using hints.
hs.grid.HINTS={
    {'f1', 'f2' , 'f3' , 'f4' , 'f5', 'f6', 'f7', 'f8', 'f9', 'f10', 'f11', 'f12', 'f13', 'f14', 'f15', 'f16'},
    {'1' , 'f11', 'f15', 'f19', 'f3', '=' , ']' , '2' , '3' , '4'  , '5'  , '6'  , '7'  , '8'  , '9'  , '0'  },
    {'Q' , 'f12', 'f16', 'f20', 'f4', '-' , '[' , 'W' , 'E' , 'R'  , 'T'  , 'Y'  , 'U'  , 'I'  , 'O'  , 'P'  },
    {'A' , 'f13', 'f17', 'f1' , 'f5', 'f7', '\\', 'S' , 'D' , 'F'  , 'G'  , 'H'  , 'J'  , 'K'  , 'L'  , ','  },
    {'X' , 'f14', 'f18', 'f2' , 'f6', 'f8', ';' , '/' , '.' , 'Z'  , 'X'  , 'C'  , 'V'  , 'B'  , 'N'  , 'M'  }
}

hs.grid.setMargins({0, 0})
hs.grid.setGrid('16x4')
hs.grid.ui.textSize = 35
hs.grid.ui.cellStrokeWidth = 5
hs.grid.ui.highlightStrokeWidth = 5

modalKey:bind('', 'G', 'Show Grid', function() hs.grid.show() end)
modalKey:bind('', 'S', 'Snap active window to grid', function() hs.grid.snap(hs.window.focusedWindow()) end)

