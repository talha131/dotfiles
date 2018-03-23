-- Launch applications

local modalKey = hs.hotkey.modal.new(hyper, 'A', 'Launch Application mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

local appShortCuts = {

    A = 'AppCode',
    C = 'Visual Studio Code',
    D = 'Dash',
    E = 'emacs',
    F = 'FirefoxDeveloperEdition',
    G = 'GitKraken',
    I = 'iterm',
    J = 'Jump Desktop',
    O = 'Microsoft Onenote',
    P = '1Password 6',
    R = 'Rambox',
    V = 'evernote',
    X = 'Xcode',
}

for key, app in pairs(appShortCuts) do

    modalKey:bind('', key, 'Launching '..app, function() hs.application.launchOrFocus(app) end, function() modalKey:exit() end)
end

