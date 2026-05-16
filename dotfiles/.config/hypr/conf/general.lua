-- ~/.config/hypr/conf/general.lua

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 5,
        border_size = 1,

        col = {
            active_border = {
                colors = {
                    "rgba(00e5ff66)",
                    "rgba(ff2ed166)",
                },
                angle = 45,
            },

            inactive_border = "rgba(ffffff10)",
        },

        layout = "dwindle",
        resize_on_border = true,
    },
})
