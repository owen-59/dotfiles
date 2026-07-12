hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border = {
                colors = {"rgba(33ccffee)", "rgba(00ff99ee)"},
                angle = 45,
            },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true;
        allow_tearing = false;
    },

    decoration = {
        rounding = 7;
        rounding_power = 3;

        active_opacity = 1;
        inactive_opacity = 0.9;

        shadow = {
          enabled = true,
          range = 4,
          render_power = 3,
          color = "rgba(1a1a1aee)",
        },

        blur = {
          enabled = true,
          size = 2,
          passes = 3,
          brightness = 0.4,
          contrast = 1.5,
          noise = 0.02,
          popups = true,
          popups_ignorealpha = 0.2,
          special = true,
          new_optimizations = true,
        },
    },
})
