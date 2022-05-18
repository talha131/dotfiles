-- Caffeine replacement
local HOME = os.getenv("HOME")
local XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME") or HOME.."/.config"
local HAMMERSPOON = XDG_CONFIG_HOME .. '/hammerspoon'

local ASSETS_PATH =  HAMMERSPOON .. '/assets/';
local iconAwake = ASSETS_PATH .."caffeine-on.pdf"
local iconSleep = ASSETS_PATH .."caffeine-off.pdf"

local caffeine = hs.menubar.new()

function setCaffeineDisplay(state)
    if state then
        caffeine:setIcon(iconAwake)
        caffeine:setTooltip(ASSETS_PATH .."Awake - machine will refuse to sleep")
    else
        caffeine:setIcon(iconSleep)
        caffeine:setTooltip("Sleepy - machine is allowed to sleep")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    hs.caffeinate.set("displayIdle", false, true)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

