-- Constants

local hyper = { "cmd", "alt", "shift", "ctrl" }

hs.hotkey.bind(hyper, 'Q', function() hs.caffeinate.lockScreen() end)

-- Launch applications
hs.hotkey.bind(hyper, '0', function() hs.application.launchOrFocus("iterm") end)

require "reload-config"
require "caffeine"
require "clipboard"
