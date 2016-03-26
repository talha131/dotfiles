function getTime()
    
    local timeTable = {}
    timeTable.start = hs.timer.localTime()
    timeTable.fin = timeTable.start + hs.timer.hours(36)
    return timeTable
end

local lastKey = nil

function flux(key)

    if lastKey == key then
        
        hs.redshift.stop()
        lastKey = nil
        return
    end

    local value = 0
    
    if key == '1' then
        value = 5500
    elseif key == '2' then
        value = 5000
    elseif key == '3' then
        value = 4500
    elseif key == '4' then
        value = 4000
    elseif key == '5' then
        value = 3500
    elseif key == '6' then
        value = 2500
    elseif key == '7' then
        value = 2000
    elseif key == '8' then
        value = 1500
    elseif key == '9' then
        value = 1000
    end

    if value ~= 0 then
        hs.redshift.start(value, getTime().start, getTime().fin, 1)
        lastKey = key
    elseif key == '0' then
        hs.redshift.start(3000, getTime().start, getTime().fin, 1, true)
    end
end

hs.hotkey.bind(hyper_space, '1', function() flux('1') end)
hs.hotkey.bind(hyper_space, '2', function() flux('2') end)
hs.hotkey.bind(hyper_space, '3', function() flux('3') end)
hs.hotkey.bind(hyper_space, '4', function() flux('4') end)
hs.hotkey.bind(hyper_space, '5', function() flux('5') end)
hs.hotkey.bind(hyper_space, '6', function() flux('6') end)
hs.hotkey.bind(hyper_space, '7', function() flux('7') end)
hs.hotkey.bind(hyper_space, '8', function() flux('8') end)
hs.hotkey.bind(hyper_space, '9', function() flux('9') end)
hs.hotkey.bind(hyper_space, '0', function() flux('0') end)

