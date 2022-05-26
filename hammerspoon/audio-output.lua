-- Volume Management
local modalKey = hs.hotkey.modal.new(hyper, 'V', 'Volume Management mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

function setVolume(v)
   local d = hs.audiodevice.defaultOutputDevice()
   if d then
       d:setOutputVolume(v)
   end
end

modalKey:bind('', '1', 'Set volume to 10%', function() setVolume(10) end, function() modalKey:exit() end)
modalKey:bind('', '2', 'Set volume to 20%', function() setVolume(20) end, function() modalKey:exit() end)
modalKey:bind('', '3', 'Set volume to 30%', function() setVolume(30) end, function() modalKey:exit() end)
modalKey:bind('', '4', 'Set volume to 40%', function() setVolume(40) end, function() modalKey:exit() end)
modalKey:bind('', '5', 'Set volume to 50%', function() setVolume(50) end, function() modalKey:exit() end)
modalKey:bind('', '6', 'Set volume to 60%', function() setVolume(60) end, function() modalKey:exit() end)
modalKey:bind('', '7', 'Set volume to 70%', function() setVolume(70) end, function() modalKey:exit() end)
modalKey:bind('', '8', 'Set volume to 80%', function() setVolume(80) end, function() modalKey:exit() end)
modalKey:bind('', '9', 'Set volume to 90%', function() setVolume(90) end, function() modalKey:exit() end)
modalKey:bind('', '0', 'Set volume to 100%', function() setVolume(100) end, function() modalKey:exit() end)
modalKey:bind('', 'm', 'Mute volume', function() setVolume(0) end, function() modalKey:exit() end)

