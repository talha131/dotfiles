-- Constants

local hyper = { "cmd", "alt", "shift", "ctrl" }

-- Reload Configuration
--- http://www.hammerspoon.org/go/#fancyreload
function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

hs.hotkey.bind(hyper, 'Q', function() hs.caffeinate.lockScreen() end)

-- Launch applications
hs.hotkey.bind(hyper, '0', function() hs.application.launchOrFocus("iterm") end)

require "caffeine"
require "clipboard"
