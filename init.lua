-- CHANGE THIS if moving the hs config out of the ~/conf system, or if the username is different.
package.path = package.path .. ";/Users/alaroldai/conf/sync/hammerspoon/?/init.lua"
package.path = package.path .. ";/Users/alaroldai/conf/sync/hammerspoon/?.lua"

local tiling = require "hs.tiling"

hs.window.animationDuration = 0


local maximised = '[0, 0, 100, 100]'

local halves = {}
halves.left_edge = '[0, 0, 50, 100]'
halves.down_edge = '[0, 50, 100, 100]'
halves.upper_edge = '[0, 0, 100, 50]'
halves.right_edge = '[50, 0, 100, 100]'

local quarters = {}
quarters.left_centred = '[0, 25, 50, 75]'
quarters.down_centred = '[50, 25, 100, 75]'
quarters.upper_centred = '[25, 0, 75, 50]'
quarters.right_centred = '[25, 50, 75, 100]'
quarters.top_left = '[0, 0, 50, 50]'
quarters.bottom_left = '[0, 50, 50, 100]'
quarters.top_right = '[50, 0, 100, 50]'
quarters.bottom_right = '[50, 50, 100, 100]'
quarters.centre = '[25, 25, 75, 75]'

local ninths = {}
ninths.cells = {}
ninths.cells.top_left = '[0, 0, 33, 33]'
ninths.cells.top = '[33, 0, 66, 33]'
ninths.cells.top_right = '[66, 0, 100, 33]'
ninths.cells.bottom_left = '[0, 66, 33, 100]'
ninths.cells.bottom = '[33, 66, 66, 100]'
ninths.cells.bottom_right = '[66, 66, 100, 100]'
ninths.cells.left_centred = '[0, 33, 33, 66]'
ninths.cells.centre = '[33, 33, 66, 66]'
ninths.cells.right_centred = '[66, 33, 100, 66]'

ninths.columns = {}
ninths.columns.left = '[0, 0, 33, 100]'
ninths.columns.centre = '[33, 0, 66, 100]'
ninths.columns.right = '[66, 0, 100, 100]'

ninths.two_columns = {}
ninths.two_columns.left = '[0, 0, 66, 100]'
ninths.two_columns.right = '[33, 0, 100, 100]'

ninths.rows = {}
ninths.rows.top = '[0, 0, 100, 33]'
ninths.rows.centre = '0, [33, 100, 66]'
ninths.rows.bottom = '[0, 66, 100, 100]'



function bind_resize_key (key, rect)
  local resize_mask = {"cmd", "alt", "ctrl"}
  hs.hotkey.bind(resize_mask, key, function()
    hs.window.focusedWindow():moveToUnit(rect)
  end)
end

bind_resize_key("forwarddelete", ninths.columns.left)
bind_resize_key("end", ninths.columns.centre)
bind_resize_key("pagedown", ninths.columns.right)
bind_resize_key("help", ninths.two_columns.left)
bind_resize_key("pageup", ninths.two_columns.right)

bind_resize_key("space", maximised)
bind_resize_key("left", halves.left_edge)
bind_resize_key("down", halves.down_edge)
bind_resize_key("up", halves.upper_edge)
bind_resize_key("right", halves.right_edge)

-- Centered edges
bind_resize_key("return", quarters.centre)
bind_resize_key("h", quarters.left_centred)
bind_resize_key("l", quarters.down_centred)
bind_resize_key("k", quarters.upper_centred)
bind_resize_key("j", quarters.right_centred)

-- Corners
bind_resize_key("u", quarters.top_left)
bind_resize_key("n", quarters.bottom_left)
bind_resize_key("[", quarters.top_right)
bind_resize_key("/", quarters.bottom_right)

-- Thirds
bind_resize_key("i", ninths.cells.top_left)
bind_resize_key("o", ninths.cells.top)
bind_resize_key("p", ninths.cells.top_right)
bind_resize_key("m", ninths.cells.bottom_left)
bind_resize_key(",", ninths.cells.bottom)
bind_resize_key(".", ninths.cells.bottom_right)
bind_resize_key("g", ninths.cells.left_centred)
bind_resize_key(";", ninths.cells.right_centred)
bind_resize_key("'", ninths.cells.centre)

local move_mask = {"alt", "ctrl"}

function bind_move_key(mask, key, move_fn)
  hs.hotkey.bind(mask, key, move_fn)
end

-- Moving windows to different screens
function moveWest()
  local win = hs.window.focusedWindow()
  win:moveToScreen(win:screen():toWest())
end
function moveEast()
  local win = hs.window.focusedWindow()
  win:moveToScreen(win:screen():toEast())
end
function moveSouth()
  local win = hs.window.focusedWindow()
  win:moveToScreen(win:screen():toSouth())
end
function moveNorth()
  local win = hs.window.focusedWindow()
  win:moveToScreen(win:screen():toNorth())
end

bind_move_key(move_mask, "h", moveWest)
bind_move_key(move_mask, "j", moveSouth)
bind_move_key(move_mask, "k", moveNorth)
bind_move_key(move_mask, "l", moveEast)

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

local wf = hs.window.filter.copy(hs.window.filter.default)

hs.hotkey.bind({"cmd", "alt"}, "h", function()
  wf:setCurrentSpace(true):focusWindowWest(nil, nil, true)
end)
hs.hotkey.bind({"cmd", "alt"}, "j", function()
  wf:setCurrentSpace(true):focusWindowSouth(nil, nil, true)
end)
hs.hotkey.bind({"cmd", "alt"}, "k", function()
  wf:setCurrentSpace(true):focusWindowNorth(nil, nil, true)
end)
hs.hotkey.bind({"cmd", "alt"}, "l", function()
  wf:setCurrentSpace(true):focusWindowEast(nil, nil, true)
end)


-- Switcher configuration
-- local switcher = hs.window.switcher.new()
-- switcher.ui.showThumbnails = false
-- switcher.ui.fontName = 'SF UI Display'
-- hs.hotkey.bind('alt', 'tab', nil, function() switcher:next() end)
-- hs.hotkey.bind('alt-shift', 'tab', nil, function() switcher:previous() end)
