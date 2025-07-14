local monitor = {}
local utils = require("modules.window.utils")

-- Helper to sort by direction
local function compareScreens(a, b, direction)
    local af = a:frame()
    local bf = b:frame()

    if direction == utils.Direction.LEFT then
        return af.x > bf.x
    elseif direction == utils.Direction.RIGHT then
        return af.x < bf.x
    elseif direction == utils.Direction.UPPER then
        return af.y > bf.y
    elseif direction == utils.Direction.LOWER then
        return af.y < bf.y
    end

    return false
end

-- Move current window to the monitor in the given direction
function monitor.To(direction)
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert("No focused window")
        return
    end

    local currentScreen = win:screen()
    local currentFrame = currentScreen:frame()

    local targetScreens = {}

    for _, screen in ipairs(hs.screen.allScreens()) do
        if screen:id() ~= currentScreen:id() then
            local frame = screen:frame()

            if direction == utils.Direction.LEFT and frame.x + frame.w <= currentFrame.x then
                table.insert(targetScreens, screen)
            elseif direction == utils.Direction.RIGHT and frame.x >= currentFrame.x + currentFrame.w then
                table.insert(targetScreens, screen)
            elseif direction == utils.Direction.UPPER and frame.y + frame.h <= currentFrame.y then
                table.insert(targetScreens, screen)
            elseif direction == utils.Direction.LOWER and frame.y >= currentFrame.y + currentFrame.h then
                table.insert(targetScreens, screen)
            end
        end
    end

    local targetScreen

    if #targetScreens > 0 then
        table.sort(targetScreens, function(a, b)
            return compareScreens(a, b, direction)
        end)
        targetScreen = targetScreens[1]
    else
        -- Round robin fallback
        local all = hs.screen.allScreens()
        table.sort(all, function(a, b)
            return compareScreens(a, b, direction)
        end)

        -- Find index of current screen
        local idx = hs.fnutils.indexOf(all, currentScreen)
        local nextIdx = idx % #all + 1 -- wrap around
        targetScreen = all[nextIdx]
    end

    -- Move the window to the target screen, maintaining relative position and size
    local targetFrame = targetScreen:frame()
    local winFrame = win:frame()

    local relativeX = (winFrame.x - currentFrame.x) / currentFrame.w
    local relativeY = (winFrame.y - currentFrame.y) / currentFrame.h
    local relativeW = winFrame.w / currentFrame.w
    local relativeH = winFrame.h / currentFrame.h

    win:setFrame({
        x = targetFrame.x + targetFrame.w * relativeX,
        y = targetFrame.y + targetFrame.h * relativeY,
        w = targetFrame.w * relativeW,
        h = targetFrame.h * relativeH
    })
end

return monitor
