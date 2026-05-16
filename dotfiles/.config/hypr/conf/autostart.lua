-- ~/.config/hypr/conf/autostart.lua
-- Execute apps once when Hyprland starts

hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
  hl.exec_cmd("dex --autostart --environment Hyprland")
  hl.exec_cmd("wl-paste --watch cliphist store")
  hl.exec_cmd("cliphist wipe")
  hl.exec_cmd("swaync")
end)
