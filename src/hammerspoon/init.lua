require("hs.ipc")

-- Double-tap Control → ctrl+` (terminal hotkey window)
local CTRL_KEYCODES = { [59] = true, [62] = true }
local DOUBLE_TAP_WINDOW = 0.3
local MAX_HOLD = 0.3

local state = { down = false, downAt = 0, interrupted = false, lastTap = 0, suppressUntil = 0 }

--- Report whether the flags contain ctrl and no other modifier.
local function onlyCtrl(flags)
  return flags.ctrl and not (flags.cmd or flags.alt or flags.shift or flags.fn)
end

--- Emit ctrl+` and ignore events for a moment so the synthetic chord can't retrigger the detector.
local function fire()
  state.lastTap = 0
  state.suppressUntil = hs.timer.secondsSinceEpoch() + 0.2
  hs.eventtap.keyStroke({ "ctrl" }, "`", 0)
end

--- Track ctrl taps and cancel on any other key or modifier.
local function handle(event)
  local now = hs.timer.secondsSinceEpoch()
  if now < state.suppressUntil then
    return false
  end

  if event:getType() == hs.eventtap.event.types.keyDown then
    state.interrupted = true
    state.lastTap = 0
    return false
  end

  local flags = event:getFlags()
  local isCtrlKey = CTRL_KEYCODES[event:getKeyCode()]

  if isCtrlKey and onlyCtrl(flags) and not state.down then
    state.down, state.downAt, state.interrupted = true, now, false
  elseif isCtrlKey and not flags.ctrl and state.down then
    state.down = false
    if state.interrupted or now - state.downAt > MAX_HOLD then
      state.lastTap = 0
    elseif now - state.lastTap <= DOUBLE_TAP_WINDOW then
      fire()
    else
      state.lastTap = now
    end
  else
    state.interrupted = true
    state.lastTap = 0
  end
  return false
end

ctrlDoubleTap = hs.eventtap.new(
  { hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown },
  handle
)
ctrlDoubleTap:start()

ctrlDoubleTapWatchdog = hs.timer.doEvery(5, function()
  if not ctrlDoubleTap:isEnabled() then
    ctrlDoubleTap:start()
  end
end)
