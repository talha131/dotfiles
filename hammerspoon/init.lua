hyper = { "cmd", "alt", "shift", "ctrl" }
hyper_space = { "cmd", "alt", "shift", "ctrl", "space" }

loggerInfo = hs.logger.new('battery', 'info')

require "reload-config"
require "window"
require "battery"
require "caffeine"
require "clipboard"
require 'red-shift'

-- Lock System
hs.hotkey.bind(hyper, 'Q', function() hs.caffeinate.lockScreen() end)
-- Sleep system
hs.hotkey.bind(hyper, 'W', function() hs.caffeinate.systemSleep() end)

-- Launch applications
hs.hotkey.bind(hyper_space, 'i', function() hs.application.launchOrFocus("iterm") end)

