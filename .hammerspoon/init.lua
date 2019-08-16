-- local pushToTalk = require("pushToTalk")
-- pushToTalk.init{"fn", "ctrl"}

local modifierKeys = {"cmd", "alt", "ctrl"}

-- FIXME: Consider refactoring for DRYness

--
-- Window mgmt
--
hs.hotkey.bind(modifierKeys, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(modifierKeys, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Use a spoon to move windows between displays
hs.loadSpoon("WindowScreenLeftAndRight")
spoon.WindowScreenLeftAndRight:bindHotkeys({
  screen_right= { modifierKeys, "Up" },
  screen_left = { modifierKeys, "Down" }
})

-- Upper left quadrant
hs.hotkey.bind(modifierKeys, "1", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Lower left quadrant
hs.hotkey.bind(modifierKeys, "2", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Upper right quadrant
hs.hotkey.bind(modifierKeys, "3", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Lower right quadrant
hs.hotkey.bind(modifierKeys, "4", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- 2/3 width left-side
hs.hotkey.bind(modifierKeys, "5", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local w = max.w * 2 / 3

  f.x = max.x
  f.y = max.y
  f.w = w
  f.h = max.h
  win:setFrame(f)
end)

-- 2/3 width right-side
hs.hotkey.bind(modifierKeys, "6", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local w = max.w * 2 / 3

  f.x = max.x + (max.w - w)
  f.y = max.y
  f.w = w
  f.h = max.h
  win:setFrame(f)
end)

-- Maximize
hs.hotkey.bind(modifierKeys, "Return", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

--
-- App launchers
--
hs.hotkey.bind(modifierKeys, "C", function()
  hs.application.launchOrFocus("Calculator")
end)
hs.hotkey.bind(modifierKeys, "E", function()
  hs.application.launchOrFocus("Emacs")
end)
hs.hotkey.bind(modifierKeys, "F", function()
  hs.application.launchOrFocus("Finder")
end)
hs.hotkey.bind(modifierKeys, "G", function()
  hs.application.launchOrFocus("Google Chrome")
end)
hs.hotkey.bind(modifierKeys, "K", function()
  hs.application.launchOrFocus("Slack")
end)
hs.hotkey.bind(modifierKeys, "M", function()
  hs.application.launchOrFocus("Mail")
end)
hs.hotkey.bind(modifierKeys, "P", function()
  hs.application.launchOrFocus("Password Gorilla")
end)
hs.hotkey.bind(modifierKeys, "S", function()
  hs.application.launchOrFocus("Safari")
end)
hs.hotkey.bind(modifierKeys, "T", function()
  hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind(modifierKeys, "V", function()
  hs.application.launchOrFocus("VLC")
end)
