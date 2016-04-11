-- Following code is based on https://github.com/ztomer/.hammerspoon/blob/master/pomodoor.lua
-- Pomodoro module

--------------------------------------------------------------------------------
-- Configuration variables
--------------------------------------------------------------------------------
local pom={}
pom.bar = {
    indicator_height = 0.2, -- ratio from the height of the menubar (0..1)
    indicator_alpha  = 0.3,
    indicator_in_all_spaces = true,
    color_time_remaining = hs.drawing.color.green,
    color_time_used      = hs.drawing.color.red,
    color_time_paused = hs.drawing.color.blue,

    table = {}
}


pom.config = {
    enable_color_bar = true,
    work_period_sec  = 35 * 60,
    rest_period_sec  = 5 * 60,
}

pom.var = { 
    is_active        = false,
    disable_count    = 0,
    work_count       = 0,
    curr_active_type = "W", -- {"W", "R"}
    time_left        = pom.config.work_period_sec,
    max_time_sec     = pom.config.work_period_sec
}

local notification = hs.notify.new({
                    title        = "Work Complete",
                    subTitle     = 'Take Rest',
                    autoWithdraw = false,
                    soundName    = 'Glass'
                })

--------------------------------------------------------------------------------
-- Color bar for pomodoor
--------------------------------------------------------------------------------

function pom_del_indicators()
    pom.bar.c_left:delete()
    pom.bar.c_used:delete()
end

function pom_draw_on_menu(target_draw, screen, offset, width, fill_color)

    local screeng                  = screen:fullFrame()
    local screen_frame_height      = screen:frame().y
    local screen_full_frame_height = screeng.y
    local height_delta             = screen_frame_height - screen_full_frame_height
    local height                   = pom.bar.indicator_height * (height_delta)

    target_draw:setSize(hs.geometry.rect(screeng.x + offset, screen_full_frame_height, width, height))
    target_draw:setTopLeft(hs.geometry.point(screeng.x + offset, screen_full_frame_height))
    target_draw:setFillColor(fill_color)
    target_draw:setFill(true)
    target_draw:setAlpha(pom.bar.indicator_alpha)
    target_draw:setLevel(hs.drawing.windowLevels.overlay)
    target_draw:setStroke(false)
    if pom.bar.indicator_in_all_spaces then
        target_draw:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
    end
    target_draw:show()
end

function pom_draw_indicator(time_left, max_time)  

    for i, screen in pairs(hs.screen.allScreens()) do

        local bars = pom.bar.table[screen:id()]
        if bars == nil then

            bars = {}
            bars.c_left = hs.drawing.rectangle(hs.geometry.rect(0,0,0,0))
            bars.c_used = hs.drawing.rectangle(hs.geometry.rect(0,0,0,0))
            pom.bar.table[screen:id()] = bars
        end

        local main_screen = screen
        -- local main_screen = hs.screen.mainScreen()
        local screeng     = main_screen:fullFrame()
        local time_ratio  = time_left / max_time
        local width       = math.ceil(screeng.w * time_ratio)
        local left_width  = screeng.w - width

        if time_left == max_time then

            pom_draw_on_menu(bars.c_left, main_screen, left_width, width,      pom.bar.color_time_paused)
            pom_draw_on_menu(bars.c_used, main_screen, 0,          left_width, pom.bar.color_time_paused)  
        else

            pom_draw_on_menu(bars.c_left, main_screen, left_width, width,      pom.bar.color_time_remaining)
            pom_draw_on_menu(bars.c_used, main_screen, 0,          left_width, pom.bar.color_time_used)  
        end
    end

end

-- draw color bar indicator, if enabled.
function draw_indicator_if_enabled()

    if (pom.config.enable_color_bar == true) then
        pom_draw_indicator(pom.var.time_left, pom.var.max_time_sec)
    end
end
--------------------------------------------------------------------------------

-- update display
local function pom_update_display()
    local time_min = math.floor( (pom.var.time_left / 60))
    local time_sec = pom.var.time_left - (time_min * 60)
    -- local str = string.format ("[%s|%02d:%02d|#%02d]", pom.var.curr_active_type, time_min, time_sec, pom.var.work_count)
    local str = string.format ("[%02d:%02d|%s]", time_min, time_sec, pom.var.curr_active_type)
    pom_menu:setTitle(str)
end

-- stop the clock
-- Stateful:
-- * Disabling once will pause the countdown
-- * Disabling twice will reset the countdown
-- * Disabling trice will shut down and hide the pomodoro timer
function pom_disable()

    local pom_was_active = pom.var.is_active
    pom.var.is_active = false

    if (pom_was_active) then
        pom_timer:stop()
    end

    pom.var.time_left         = pom.config.work_period_sec
    pom_update_display()

    --[[
    if (pom.var.disable_count == 0) then
    if (pom_was_active) then
    pom_timer:stop()
    end
    elseif (pom.var.disable_count == 1) then
    pom.var.time_left         = pom.config.work_period_sec
    pom.var.curr_active_type  = "W"
    pom_update_display()
    elseif (pom.var.disable_count >= 2) then
    if pom_menu == nil then 
    pom.var.disable_count = 2
    return
    end

    pom_menu:delete()
    pom_menu = nil
    pom_timer:stop()
    pom_timer = nil
    pom_del_indicators()
    end

    pom.var.disable_count = pom.var.disable_count + 1
    --]]

end

-- update pomodoro timer
local function pom_update_time()
    if pom.var.is_active == false then

        draw_indicator_if_enabled()
        return
    else
        pom.var.time_left = pom.var.time_left - 1

        if (pom.var.time_left <= 0 ) then
            pom_disable()
            if pom.var.curr_active_type == "W" then 

                notification:send()
                hs.alert.show("Work Complete. Take Rest", 20)
                pom.var.work_count        =  pom.var.work_count + 1 
                pom.var.curr_active_type  = "R"
                -- pom.var.time_left         = pom.config.rest_period_sec
                -- pom.var.max_time_sec      = pom.config.rest_period_sec
            else 
                hs.alert.show("Done resting", 2)
                pom.var.curr_active_type  = "W"
                pom.var.time_left         = pom.config.work_period_sec
                pom.var._max_time_sec     = pom.config.work_period_sec 
            end
        end

        draw_indicator_if_enabled()

    end
end

-- update menu display
local function pom_update_menu()
    pom_update_time()
    pom_update_display()
end

local function pom_menu_clicked()
    if (pom.var.is_active) then
        pom.var.time_left = 0
        pom_update_menu()
    else
        pom_enable()
    end
end

local function pom_create_menu(pom_origin)
    if pom_menu == nil then
        pom_menu = hs.menubar.new()
        pom_menu:setClickCallback(pom_menu_clicked)
    end
end

-- start the pomodoro timer
function pom_enable()
    pom.var.disable_count = 0;
    if (pom_is_active) then
        return
        elseif pom_timer == nil then
            pom_create_menu()
            --pom_init_indicator()
            pom_timer = hs.timer.new(1, pom_update_menu)
        end

        pom.var.curr_active_type = "W"
        pom.var.is_active = true
        pom_timer:start()
    end

    -- reset work count
    -- TODO - reset automatically every day
    function pom_reset_work()
        pom.var.work_count = 0;
    end

    -- Use examples:

    -- init pomodoro -- show menu immediately
    pom_create_menu()
    pom_update_menu()

    -- show menu only on first pom_enable
    hs.hotkey.bind(hyper, '0', function() pom_menu_clicked() end)
