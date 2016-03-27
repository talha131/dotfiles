hyper = { "cmd", "alt", "shift", "ctrl" }

loggerInfo = hs.logger.new('My Settings', 'info')

require 'battery'
require 'pomodoor'
require 'caffeine'
require 'clipboard'
require 'launch-applications'
require 'red-shift'
require 'reload-config'
require 'window-management'

-- Lock System
hs.hotkey.bind(hyper, 'Q', function() hs.caffeinate.lockScreen() end)
-- Sleep system
hs.hotkey.bind(hyper, 'S', function() hs.caffeinate.systemSleep() end)

