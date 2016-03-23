hyper = { "cmd", "alt", "shift", "ctrl" }

require "reload-config"
require "window"
require "battery"
require "caffeine"
require "clipboard"

-- Lock System
hs.hotkey.bind(hyper, 'Q', function() hs.caffeinate.lockScreen() end)

-- Launch applications
hs.hotkey.bind(hyper, '0', function() hs.application.launchOrFocus("iterm") end)

