-- CHANGE THIS if moving the hs config out of the ~/conf system, or if the username is different.
package.path = package.path .. ";/Users/alaroldai/conf/sync/hammerspoon/?/init.lua"
package.path = package.path .. ";/Users/alaroldai/conf/sync/hammerspoon/?.lua"

local tiling = require "hs.tiling"

-- Maximise window
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "space", function()
    hs.window.focusedWindow():maximize(0)
end)

function moveWindowToScreen(win, scr)
    local screen = win:screen()
    local frame = screen:frame()

    local relx = (win:frame().x - frame.x) / frame.w
    local rely = (win:frame().y - frame.y) / frame.h
    local relw = win:size().w / frame.w
    local relh = win:size().h / frame.h

    if not scr then
        return
    end

    frame = scr:frame()

    win:setTopLeft(hs.geometry.point(  frame.x + relx * frame.w,
                                    frame.y + rely * frame.h))
    win:setSize(hs.geometry.size(relw * frame.w, relh * frame.h))
end


function sameScreenReposition(win, x, y, w, h)
    local frame = win:screen():frame()
    win:setFrame(hs.geometry.rect(frame.x + frame.w * x, frame.y + frame.h * y, frame.w * w, frame.h * h), 0)
end

-- Same-screen positioning
-- Whole edges
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "left", function()
    sameScreenReposition(hs.window.focusedWindow(), 0, 0, 0.5, 1)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "down", function()
    sameScreenReposition(hs.window.focusedWindow(), 0, 0.5, 1, 0.5)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "up", function()
    sameScreenReposition(hs.window.focusedWindow(), 0, 0, 1, 0.5)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "right", function()
    sameScreenReposition(hs.window.focusedWindow(), 0.5, 0, 0.5, 1)
end)

-- Centered edges
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "h", function()
    sameScreenReposition(hs.window.focusedWindow(), 0, 0.25, 0.5, 0.5)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "l", function()
    sameScreenReposition(hs.window.focusedWindow(), 0.5, 0.25, 0.5, 0.5)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "k", function()
    sameScreenReposition(hs.window.focusedWindow(), 0.25, 0, 0.5, 0.5)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "j", function()
    sameScreenReposition(hs.window.focusedWindow(), 0.25, 0.5, 0.5, 0.5)
end)

-- Center
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", function()
    sameScreenReposition(hs.window.focusedWindow(), 0.25, 0.25, 0.5, 0.5)
end)

-- Corners
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "u", function()
    sameScreenReposition(hs.window.focusedWindow(), 0, 0, 0.5, 0.5)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "n", function()
    sameScreenReposition(hs.window.focusedWindow(), 0, 0.5, 0.5, 0.5)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "[", function()
    sameScreenReposition(hs.window.focusedWindow(), 0.5, 0, 0.5, 0.5)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "/", function()
    sameScreenReposition(hs.window.focusedWindow(), 0.5, 0.5, 0.5, 0.5)
end)

-- Moving windows to different screens
function moveWest()
    moveWindowToScreen(hs.window.focusedWindow(), hs.window.focusedWindow():screen():toWest())
end
function moveEast()
    moveWindowToScreen(hs.window.focusedWindow(), hs.window.focusedWindow():screen():toEast())
end
function moveSouth()
    moveWindowToScreen(hs.window.focusedWindow(), hs.window.focusedWindow():screen():toSouth())
end
function moveNorth()
    moveWindowToScreen(hs.window.focusedWindow(), hs.window.focusedWindow():screen():toNorth())
end

hs.hotkey.bind({"alt", "ctrl"}, "h", moveWest)
hs.hotkey.bind({"alt", "ctrl"}, "j", moveSouth)
hs.hotkey.bind({"alt", "ctrl"}, "k", moveNorth)
hs.hotkey.bind({"alt", "ctrl"}, "l", moveEast)

hs.hotkey.bind({"alt", "ctrl"}, "space", function()
  tiling.goToLayout("gp-vertical")
end)
hs.hotkey.bind({"alt", "ctrl"}, "left", function()
  tiling.cycle(-1)
end)
hs.hotkey.bind({"alt", "ctrl"}, "right", function()
  tiling.cycle(1)
end)
hs.hotkey.bind({"alt", "ctrl"}, "up", function()
  tiling.promote()
end)
-- hs.hotkey.bind({"alt", "ctrl"}, "down", function()
--   tiling.cycle(1)
-- end)

-- hs.hotkey.bind({"cmd", "alt"}, "h", function()
--     hs.window.focusedWindow():focuswindow_west()
-- end)
-- hs.hotkey.bind({"cmd", "alt"}, "j", function()
--     hs.window.focusedWindow():focuswindow_south()
-- end)
-- hs.hotkey.bind({"cmd", "alt"}, "k", function()
--     hs.window.focusedWindow():focuswindow_north()
-- end)
-- hs.hotkey.bind({"cmd", "alt"}, "l", function()
--     hs.window.focusedWindow():focuswindow_east()
-- end)
