-- Caffeine replacement
local iconAwake = ASSETS_PATH .."caffeine-on.pdf"
local iconSleep = ASSETS_PATH .."caffeine-off.pdf"

local caffeine = hs.menubar.new()

function setCaffeineDisplay(state)
    if state then
        caffeine:setIcon(iconAwake)
        caffeine:setTooltip("Awake - machine will refuse to sleep")
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

