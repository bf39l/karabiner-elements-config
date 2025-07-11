-- print("Loading modules...")  -- Debugging print statement
local winResize = require("modules.window.resize")
local winResizeUtils = require("modules.window.utils")
local apps = require("modules.applications.apps")


-- Define Hotkeys 
-- ### window management ###
-- hs.window.animationDuration = 0.1 → almost instant but still smooth
-- hs.window.animationDuration = 0.25 → default animation speed
-- hs.window.animationDuration = 0 → no animation (snaps instantly)
hs.window.animationDuration = 0.03
hs.hotkey.bind({"ctrl", "alt", "shift"}, "left", function()
    winResize.toHalf(winResizeUtils.Direction.LEFT)
end)

hs.hotkey.bind({"ctrl", "alt", "shift"}, "right", function()
    winResize.toHalf(winResizeUtils.Direction.RIGHT)
end)

hs.hotkey.bind({"ctrl", "alt", "shift"}, "up", function()
    winResize.toHalf(winResizeUtils.Direction.UPPER)
end)

hs.hotkey.bind({"ctrl", "alt", "shift"}, "down", function()
    winResize.toHalf(winResizeUtils.Direction.LOWER)
end)

hs.hotkey.bind({"ctrl", "alt", "shift"}, "return", function()
    local win = hs.window.frontmostWindow()
    if win then
        winResize.toggleMax(win)
    end
end)

hs.hotkey.bind({"ctrl", "alt", "shift"}, "=", function()
    winResize.by(30)
end)

hs.hotkey.bind({"ctrl", "alt", "shift"}, "-", function()
    winResize.by(-30, 430, 400, 10)
end)

--- ### applications management ###
hs.application.enableSpotlightForNameSearches(true)
hs.hotkey.bind({"ctrl", "alt", "shift"}, "t", function()
    apps.launchOrFocus("/Applications/iTerm.app")
end)

hs.hotkey.bind({"ctrl", "alt", "shift"}, "b", function()
    apps.launchOrFocus("/Applications/Firefox.app")
end)