hyper = { "cmd", "alt", "shift", "ctrl" }
hyper_space = { "cmd", "alt", "shift", "ctrl", "space" }

loggerInfo = hs.logger.new('battery', 'info')

require "reload-config"
require "window"
require "battery"
require "caffeine"
require "clipboard"
require 'red-shift'
require 'launch-applications'

-- Lock System
hs.hotkey.bind(hyper, 'Q', function() hs.caffeinate.lockScreen() end)
-- Sleep system
hs.hotkey.bind(hyper, 'W', function() hs.caffeinate.systemSleep() end)

