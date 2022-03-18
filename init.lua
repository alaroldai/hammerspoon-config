hs.window.animationDuration = 0
for key, position in pairs({["'"] = "[33, 33, 66, 66]", [","] = "[33, 66, 66, 100]", ["."] = "[50, 50, 100, 100]", ["/"] = "[66, 66, 100, 100]", [";"] = "[66, 33, 100, 66]", ["["] = "[66, 0, 100, 33]", ["end"] = "[33, 0, 66, 100]", ["return"] = "[25, 25, 75, 75]", down = "[0 50 100 100]", f13 = "[0, 0, 100, 33]", f14 = "[0, 33, 100, 66]", f15 = "[0, 66, 100, 100]", forwarddelete = "[0, 0, 33, 100]", g = "[0, 33, 33, 66]", h = "[0, 25, 50, 75]", help = "[0, 0, 66, 100]", i = "[33, 0, 66, 33]", j = "[25, 50, 75, 100]", k = "[25, 0, 75, 50]", l = "[50, 25, 100, 75]", left = "[0 0 50 100]", m = "[0, 50, 50, 100]", n = "[0, 66, 33, 100]", o = "[50, 0, 100, 50]", pagedown = "[66, 0, 100, 100]", pageup = "[33, 0, 100, 100]", right = "[50 0 100 100]", space = "[0, 0, 100, 100]", u = "[0, 0, 50, 50]", up = "[0 0 100 50]", y = "[0, 0, 33, 33]"}) do
  local function _0_()
    local w = hs.window.focusedWindow()
    return w:moveToUnit(position)
  end
  hs.hotkey.bind({"cmd", "alt", "ctrl"}, key, _0_)
end
for key, direction in pairs({h = "toWest", j = "toSouth", k = "toNorth", l = "toEast"}) do
  local function _0_()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local direction0 = screen[direction](screen)
    return win:moveToScreen(direction0)
  end
  hs.hotkey.bind({"alt", "ctrl"}, key, _0_)
end
local function _0_(name, params)
  local appName = params.appName
  local spaces = require("hs.spaces")
  local target
  do
    local _1_ = params.appName
    if _1_ then
      local _2_ = hs.application.get(_1_)
      if _2_ then
        target = _2_:mainWindow()
      else
        target = _2_
      end
    else
      target = _1_
    end
  end
  local win = hs.window.focusedWindow()
  local screen = (hs.screen.mainScreen() or hs.mouse.getCurrentScreen() or hs.screen.primaryScreen())
  local targetSpace = spaces.activeSpaceOnScreen()
  local frame
  if (win and (win:subrole() == "AXStandardWindow")) then
    frame = win:frame()
  else
    local w = target:frame()
    local s = target:screen():frame()
    local ts = screen:frame()
    frame = hs.geometry.rect((ts.w * ((w.x - s.x) / s.w)), (ts.h * ((w.y - s.y) / s.h)), (ts.w * (w.w / s.w)), (ts.h * (w.h / s.h)))
  end
  print(targetSpace)
  local _3_ = target
  _3_:setFrame(frame)
  spaces.moveWindowToSpace(_3_, targetSpace)
  _3_:focus()
  return _3_
end
return hs.urlevent.bind("pullWindow", _0_)
