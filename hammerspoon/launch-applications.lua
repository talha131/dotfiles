-- Launch applications

local modalKey = hs.hotkey.modal.new(hyper, 'A', 'Launch Application mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

local appShortCuts = {

    -- Most used
    D = 'Google Chrome',
    Q = 'TickTick',
    S = 'Slack',
    W = 'iterm',

    -- Less frequent
    C = 'Visual Studio Code',
    P = '1Password',
    T = 'Telegram Desktop',
    X = 'Xcode',
    Y = 'WhatsApp',
}

for key, app in pairs(appShortCuts) do

    modalKey:bind('', key, 'Launching '..app, function() hs.application.launchOrFocus(app) end, function() modalKey:exit() end)
end

