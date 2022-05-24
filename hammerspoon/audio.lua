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

-- Mic Management
local modalKey = hs.hotkey.modal.new(hyper, 'M', 'Mic Management mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

function toggleInput(v)
   local default = hs.audiodevice.defaultInputDevice()
   local isMute = default:inputMuted()

   local devs = hs.audiodevice.allInputDevices()

   for _, d in ipairs(devs) do
       d:setInputMuted(not isMute)

       -- set default input device to built in Mic
       if d:uid() == 'BuiltInMicrophoneDevice' then
           d:setDefaultInputDevice()
       end
   end

   if not isMute then
       hs.alert.show('Mute Mic')
   else
       hs.alert.show('Enable Mic')
   end
end

modalKey:bind('', 'm', 'Toggle mic', function() toggleInput() end, function() modalKey:exit() end)
