-- Volume Management
local modalKey = hs.hotkey.modal.new(hyper, 'V', 'Volume Management mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

function setVolume(v)
   local d = hs.audiodevice.defaultOutputDevice()
   if d then
       d:setOutputVolume(v)
   end
end

modalKey:bind('', 'b', 'Set volume to 50%', function() setVolume(50) end, function() modalKey:exit() end)
modalKey:bind('', 'm', 'Mute volume', function() setVolume(0) end, function() modalKey:exit() end)

