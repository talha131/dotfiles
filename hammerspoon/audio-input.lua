-- Mic Management
-- local modalKey = hs.hotkey.modal.new(hyper, 'M', 'Mic Management mode')
-- modalKey:bind('', 'escape', function() modalKey:exit() end)

local logger = hs.logger.new('audio-in', 'debug')

function toggleInput(v)
   local builtin = hs.audiodevice.findDeviceByUID('BuiltInMicrophoneDevice')
   local isMute = builtin:inputMuted()
   logger.d(builtin:uid(), 'state:', (isMute and 'mute' or 'unmute'))

   local devs = hs.audiodevice.allInputDevices()

   local setInputDevice = false

   logger.d("set all audio input state:", (not isMute and 'mute' or 'unmute'))
   for _, d in ipairs(devs) do
       d:setInputMuted(not isMute)
       logger.d(d:uid(), 'after set state:', (d:inputMuted() and 'mute' or 'unmute'))

       -- prefer external headphone
       if d:uid() == 'BuiltInHeadphoneInputDevice' then
           d:setDefaultInputDevice()
           setInputDevice = true
           logger.i('set default audio input device:', d:uid())
       end

       -- if headphone not found then set default input device to built in Mic
       if not setInputDevice and d:uid() == 'BuiltInMicrophoneDevice' then
           d:setDefaultInputDevice()
           logger.i('set default audio input:', d:uid())
       end
   end

   if not isMute then
       hs.alert.show('Mute Mic')
   else
       hs.alert.show('Enable Mic')
   end
   setMicDisplay(not isMute)
end

-- modalKey:bind('', 'm', "Toggle Mic", function() toggleInput() end, function() modalKey:exit() end)

-- Mic icon
local micOn = ASSETS_PATH .. "mic-on.png"
local micOff = ASSETS_PATH .. "mic-off.png"

local micIcon = hs.menubar.new()

function setMicDisplay(isMute)
    if isMute then
        micIcon:setIcon(micOff)
        micIcon:setTooltip("Mic is off")
    else
        micIcon:setIcon(micOn)
        micIcon:setTooltip("Mic is ON")
    end
end

function micIconClicked()
    toggleInput()
end

if micIcon then
    micIcon:setClickCallback(toggleInput)

    local default = hs.audiodevice.defaultInputDevice()
    local isMute = default:inputMuted()
    setMicDisplay(isMute)
end


