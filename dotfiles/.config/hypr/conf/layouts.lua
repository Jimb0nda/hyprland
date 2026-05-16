-- ~/.config/hypr/conf/layouts.lua

hl.config({
  dwindle = {
    -- pseudotile was removed from the dwindle config in 0.55.
    -- Pseudotiling is now toggled with the window.pseudo dispatcher,
    -- which we will add back when converting binds.conf.
    preserve_split = true,
  },

  master = {
    -- new_status = "master",
    orientation = "left",
  },
})
