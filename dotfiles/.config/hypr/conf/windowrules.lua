-- ~/.config/hypr/conf/windowrules.lua
-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

hl.window_rule({
  name = "network-tui-floating",
  match = {
    class = "network-tui",
  },
  float = true,
  size = { 840, 620 },
  center = true,
  pin = true,
})
