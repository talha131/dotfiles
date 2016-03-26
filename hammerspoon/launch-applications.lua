-- Launch applications

local modalKey = hs.hotkey.modal.new(hyper, 'A', 'Launch Application  mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

local appShortCuts = {

    D = 'Dash',
    E = 'evernote',
    F = 'firefox',
    G = 'Github Desktop',
    I = 'iterm',
    O = 'Microsoft Onenote',
    S = 'slack',
    V = 'MacVim',
}

for key, app in pairs(appShortCuts) do

    modalKey:bind('', key, function() hs.application.launchOrFocus(app) end, function() modalKey:exit() end)
end


local chromeAppShortCuts = {

    H = {id = 'oppompclolbipehgmpngoaalfhfdpdhl',
    title = 'Habits'},

    X = {id = 'ggohgaegpbmbmmmoobmogjfjopncbnfb',
    title = 'Expenses'}
}

function launchOrFocusChromeApp(key)

    if chromeAppShortCuts[key] == nil then

        return
    end

    local appWindow = hs.window.find(chromeAppShortCuts[key].title)
    if appWindow ~= nil then

        appWindow:focus()
    else

        hs.execute('/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome --app-id=' .. chromeAppShortCuts[key].id)
    end
end

for key in pairs(chromeAppShortCuts) do

    modalKey:bind('', key, function() launchOrFocusChromeApp(key) end, function() modalKey:exit() end)
end

