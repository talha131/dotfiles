-- Caffeine replacement
local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setIcon("caffeine-on.pdf")
        caffeine:setTooltip("Awake - machine will refuse to sleep")
    else
        caffeine:setIcon("caffeine-off.pdf")
        caffeine:setTooltip("Sleepy - machine is allowed to sleep")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

