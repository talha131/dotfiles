-- Launch applications

local modalKey = hs.hotkey.modal.new(hyper, 'A', 'Launch Application mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

local appShortCuts = {

    A = 'App Code',
    D = 'Dash',
    E = 'evernote',
    F = 'firefox',
    G = 'Github Desktop',
    I = 'iterm',
    J = 'Jump Desktop',
    O = 'Microsoft Onenote',
    S = 'slack',
    V = 'MacVim',
    X = 'Xcode'
}

for key, app in pairs(appShortCuts) do

    modalKey:bind('', key, 'Launching '..app, function() hs.application.launchOrFocus(app) end, function() modalKey:exit() end)
end

