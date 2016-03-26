-- Launch applications

local modalKey = hs.hotkey.modal.new(hyper, 'A', 'Launch Application  mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

function launchOrFocusChromeApp(key)

    local apps = {}
    apps['H'] = {id = 'oppompclolbipehgmpngoaalfhfdpdhl',
              title = 'Habits'}
    apps['X'] = {id = 'ggohgaegpbmbmmmoobmogjfjopncbnfb',
              title = 'Expenses'}

    if key ~= 'H' and key ~= 'X' then

        return
    end

    local appWindow = hs.window.find(apps[key].title)
    if appWindow ~= nil then

        appWindow:focus()
    else

        hs.execute('/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome --app-id=' .. apps[key].id)
    end
end

modalKey:bind('', 'D', function() hs.application.launchOrFocus('Dash') end, function() modalKey:exit() end)
modalKey:bind('', 'E', function() hs.application.launchOrFocus('evernote') end, function() modalKey:exit() end)
modalKey:bind('', 'F', function() hs.application.launchOrFocus('firefox') end, function() modalKey:exit() end)
modalKey:bind('', 'G', function() hs.application.launchOrFocus('Github Desktop') end, function() modalKey:exit() end)
modalKey:bind('', 'H', function() launchOrFocusChromeApp('H') end, function() modalKey:exit() end)
modalKey:bind('', 'I', function() hs.application.launchOrFocus('iterm') end, function() modalKey:exit() end)
modalKey:bind('', 'O', function() hs.application.launchOrFocus('Microsoft Onenote') end, function() modalKey:exit() end)
modalKey:bind('', 'S', function() hs.application.launchOrFocus('slack') end, function() modalKey:exit() end)
modalKey:bind('', 'V', function() hs.application.launchOrFocus('MacVim') end, function() modalKey:exit() end)
modalKey:bind('', 'X', function() launchOrFocusChromeApp('X') end, function() modalKey:exit() end)

-- modalKey:bind('', '1', function() hs.application.launchOrFocus('') end, function() modalKey:exit() end)
