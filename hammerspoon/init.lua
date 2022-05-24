hyper = { "cmd", "alt", "shift", "ctrl" }

-- paths
HOME = os.getenv("HOME")
XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME") or HOME.."/.config"
HAMMERSPOON = XDG_CONFIG_HOME .. '/hammerspoon'
ASSETS_PATH =  HAMMERSPOON .. '/assets/';

loggerInfo = hs.logger.new('My Settings', 'info')

require 'caffeine'
-- require 'clipboard'
require 'launch-applications'
require 'launch-chrome-applications'
require 'red-shift'
require 'window-management'

local modalKey = hs.hotkey.modal.new(hyper, 'P', 'System Actions')
modalKey:bind('', 'escape', function() modalKey:exit() end)
-- Lock System
modalKey:bind('', 'Q', 'Lock system', function() hs.caffeinate.lockScreen() end)
-- Sleep system
modalKey:bind('', 'S', 'Put system to sleep',function() 
    modalKey:exit()
    hs.caffeinate.systemSleep() 
end)

-- Window Hints
hs.hints.style = 'vimperator'
hs.hotkey.bind(hyper, 'H', 'Show window hints', hs.hints.windowHints)

-- Auto Reload Configuration
hs.pathwatcher.new(HAMMERSPOON, hs.reload):start()
hs.alert.show("Config loaded")
