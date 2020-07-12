-- Launch applications

local modalKey = hs.hotkey.modal.new(hyper, 'A', 'Launch Application mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

local appShortCuts = {

    C = 'Visual Studio Code',
    D = 'Dash',
    F = 'Firefox Developer Edition',
    G = 'Gmail talha131',
    I = 'iterm',
    L = 'Dynalist',
    P = '1Password 7',
    Q = 'Qt Creator',
    R = 'Google Chrome',
    S = 'Slack-Web',
    T = 'TickTick',
    W = 'WhatsApp',
    V = 'evernote',
    X = 'Xcode',
}

for key, app in pairs(appShortCuts) do

    modalKey:bind('', key, 'Launching '..app, function() hs.application.launchOrFocus(app) end, function() modalKey:exit() end)
end

