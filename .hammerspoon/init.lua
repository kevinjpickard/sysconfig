-- System Variables --
hs.window.animationDuration = 0 -- Turn off window animation, its smoother

-- Tiling Init -- 
local tiling = require "hs.tiling"
local hotkey = require "hs.hotkey"
local mash = {"ctrl", "cmd"}

-- If you want to set the layouts that are enabled --
tiling.set('layouts', {
  'fullscreen', 'main-vertical'
})

hotkey.bind(mash, "c", function() tiling.cycleLayout() end)
hotkey.bind(mash, "j", function() tiling.cycle(1) end)
hotkey.bind(mash, "k", function() tiling.cycle(-1) end)
hotkey.bind(mash, "space", function() tiling.promote() end)
hotkey.bind(mash, "f", function() tiling.goToLayout("fullscreen") end)

-- Spotify Hotkeys --
hotkey.bind(mash, ".", function() hs.spotify.next() hs.spotify.displayCurrentTrack() end)
hotkey.bind(mash, ",", function() hs.spotify.previous() end)
hotkey.bind(mash, "/", function() hs.spotify.displayCurrentTrack() end)
hotkey.bind(mash, "p", function() hs.spotify.playpause() end)

-- Volume Control --
local volumeIncrement = 5
hotkey.bind(mash, "[", function() hs.audiodevice.defaultOutputDevice():setVolume(hs.audiodevice.current().volume - volumeIncrement) end)
hotkey.bind(mash, "]", function() hs.audiodevice.defaultOutputDevice():setVolume(hs.audiodevice.current().volume + volumeIncrement) end)

-- Reload hammerspoon configs
hs.hotkey.bind({"cmd", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

-- Lock
hotkey.bind(mash, "l", function() hs.caffeinate.lockScreen() end)

require('aerosnap')
