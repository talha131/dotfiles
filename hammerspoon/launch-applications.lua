-- Launch applications

local modalKey = hs.hotkey.modal.new(hyper, 'A', 'Launch Application mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

local appShortCuts = {

    B = 'Bitwarden',
    C = 'Visual Studio Code',
    D = 'Dash',
    F = 'FirefoxDeveloperEdition',
    I = 'iterm',
    P = '1Password 6',
    Q = 'Qt Creator',
    R = 'Google Chrome',
    S = 'Slack',
    V = 'evernote',
    X = 'Xcode',
}

for key, app in pairs(appShortCuts) do

    modalKey:bind('', key, 'Launching '..app, function() hs.application.launchOrFocus(app) end, function() modalKey:exit() end)
end

