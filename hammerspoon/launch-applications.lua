-- Launch applications

local modalKey = hs.hotkey.modal.new(hyper, 'A', 'Launch Application mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

local appShortCuts = {

    A = { appName = 'Google Gemini', os = "chromeOS" },
    D = { appName = 'Google Chrome', os = "macOS" },
    Q = { appName = 'TickTick', os = "chromeOS" },
    S = { appName = 'Slack', os = "macOS" },
    W = { appName = 'iterm', os = "macOS" },
    C = { appName = 'Visual Studio Code', os = "macOS" },
    P = { appName = '1Password', os = "macOS" },
    X = { appName = 'Xcode', os = "macOS" },

  -- Social apps
    T = { appName = 'Telegram Desktop', os = "macOS" },
    Y = { appName = 'WhatsApp', os = "macOS" },
    U = { appName = 'Discord', os = "macOS" },
}

for key, app in pairs(appShortCuts) do
  modalKey:bind('', key, 'Launching ' .. app.appName, 
    function()
      if app.os == 'macOS' then
        hs.application.launchOrFocus(app.appName)
      elseif app.os == 'chromeOS' then
        hs.application.launchOrFocus(os.getenv('HOME') .. '/Applications/Chrome Apps.localized/' .. app.appName .. '.app')
      end
    end, 
    function() 
      modalKey:exit() 
    end
  )
end

