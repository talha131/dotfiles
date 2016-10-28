-- Launch applications

local modalKey = hs.hotkey.modal.new(hyper, 'A', 'Launch Application mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

local appShortCuts = {

    C = 'Visual Studio Code',
    D = 'Dash',
    E = 'evernote',
    F = 'FirefoxDeveloperEdition',
    G = 'GitKraken',
    I = 'iterm',
    J = 'Jump Desktop',
    O = 'Microsoft Onenote',
    P = '1Password 6',
    S = 'Slack',
    V = 'MacVim',
    X = 'Xcode',
    Z = 'Franz'
}

for key, app in pairs(appShortCuts) do

    modalKey:bind('', key, 'Launching '..app, function() hs.application.launchOrFocus(app) end, function() modalKey:exit() end)
end

