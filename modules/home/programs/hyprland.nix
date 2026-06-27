{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    extraConfig = ''

          -- This is an example Hyprland Lua config file.
          -- Refer to the wiki for more information.
          -- https://wiki.hypr.land/Configuring/Start/

          -- Please note not all available settings / options are set here.
          -- For a full list, see the wiki

          -- You can (and should!!) split this configuration into multiple files
          -- Create your files separately and then require them like this:
          -- require("myColors")


          ------------------
          ---- MONITORS ----
          ------------------

          -- See https://wiki.hypr.land/Configuring/Basics/Monitors/
          hl.monitor({
            output   = "eDP-1",
            mode     = "2256x1504@60",
            position = "auto",
            scale    = "1.57",
          })
          hl.monitor({
            output   = "DP-1",
            mode     = "preferred",
            position = "auto",
            scale    = "1",
          })
          hl.monitor({
            output   = "DP-2",
            mode     = "preferred",
            position = "auto",
            scale    = "1",
          })
          hl.monitor({
            output   = "DP-3",
            mode     = "preferred",
            position = "auto",
            scale    = "1",
          })
          hl.monitor({
            output   = "",
            mode     = "preferred",
            position = "auto",
            scale    = "1",
          })


          ---------------------
          ---- MY PROGRAMS ----
          ---------------------

          -- Set programs that you use
          local terminal = "kitty"
          local EDITOR = "nvf"
          local fileManager = "kitty --class=yazi -e 'yazi'"
          local menu = "rofi -show drun"

          -------------------
          ---- AUTOSTART ----
          -------------------

          -- See https://wiki.hypr.land/Configuring/Basics/Autostart/

          -- Autostart necessary processes (like notifications daemons, status bars, etc.)
          -- Or execute your favorite apps at launch like this:
          --
          hl.on("hyprland.start", function()
            hl.exec_cmd("swaync & libnotify")
            hl.exec_cmd("hyprpaper")
            hl.exec_cmd("hypridle")
            hl.exec_cmd("firefox")
            hl.exec_cmd("openrgb --profile pink")
            hl.exec_cmd("waybar")
            hl.exec_cmd("kitty -e btop", { workspace = 4 })
            hl.exec_cmd("vesktop --class=vesktop")
            hl.exec_cmd("hyprlock")
            hl.exec_cmd("hyprctl setcursor Nordzy-catppuccin-mocha-dark 30")
            hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme Nordic-darker   # for GTK4 apps")
            hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Nordic-darker   # for GTK3 apps")
            hl.exec_cmd("gsettings set org.gnome.desktop.wm.preferences theme Nordic-darker")
          end)

          -------------------------------
          ---- ENVIRONMENT VARIABLES ----
          -------------------------------

          -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

          hl.env("XCURSOR_SIZE", "24") hl.env("HYPRCURSOR_SIZE", "24") hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
          hl.env("GTK_THEME", "Nordic-darker")
          hl.env("HYPRCURSOR_THEME", "Nordzy-catppuccin-mocha-dark")
          hl.env("HYPRCURSOR_SIZE", "30")
          hl.env("GDK_SCALE", "2")
          hl.env("XDG_MENU_PREFIX", "plasma")

          -----------------------
          ----- PERMISSIONS -----
          -----------------------

          -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
          -- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
          -- for security reasons

          -- hl.config({
          --   ecosystem = {
          --     enforce_permissions = true,
          --   },
          -- })

          -- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
          -- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
          -- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


          -----------------------
          ---- LOOK AND FEEL ----
          -----------------------

          -- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
          hl.config({
            general = {
              gaps_in          = 5,
              gaps_out         = 20,

              border_size      = 2,

              col              = {
                active_border   = { colors = { "rgba(ff1493ff)", "rgba(ffb6c1ff)" }, angle = 45 },
                inactive_border = "rgba(595959aa)",
              },

              -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
              resize_on_border = false,

              -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
              allow_tearing    = false,

              layout           = "dwindle",
            },

            decoration = {
              rounding         = 10,
              rounding_power   = 2,

              -- Change transparency of focused and unfocused windows
              active_opacity   = 1.0,
              inactive_opacity = 1.0,

              shadow           = {
                enabled      = true,
                range        = 4,
                render_power = 3,
                color        = "0xee1a1a1a",
              },

              blur             = {
                enabled  = true,
                size     = 3,
                passes   = 1,
                vibrancy = 0.1696,
              },
            },

            animations = {
              enabled = true,
            },
          })

          -- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
          hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
          hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
          hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
          hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
          hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

          -- Default springs
          hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

          hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
          hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
          hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
          hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
          hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
          hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
          hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
          hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
          hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
          hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
          hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
          hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
          hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
          hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
          hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
          hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
          hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

          -- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
          -- "Smart gaps" / "No gaps when only"
          -- uncomment all if you wish to use that.
          -- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
          -- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
          -- hl.window_rule({
          --     name  = "no-gaps-wtv1",
          --     match = { float = false, workspace = "w[tv1]" },
          --     border_size = 0,
          --     rounding    = 0,
          -- })
          -- hl.window_rule({
          --     name  = "no-gaps-f1",
          --     match = { float = false, workspace = "f[1]" },
          --     border_size = 0,
          --     rounding    = 0,
          -- })

          -- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
          hl.config({
            dwindle = {
              preserve_split = true, -- You probably want this
            },
          })

          -- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
          hl.config({
            master = {
              new_status = "master",
            },
          })

          -- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
          hl.config({
            scrolling = {
              fullscreen_on_one_column = true,
            },
          })

          ----------------
          ----  MISC  ----
          ----------------

          hl.config({
            misc = {
              force_default_wallpaper = 1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
              disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
            },
          })


          ---------------
          ---- INPUT ----
          ---------------

          hl.config({
            input = {
              kb_layout    = "us",
              kb_variant   = "",
              kb_model     = "",
              kb_options   = "",
              kb_rules     = "",

              follow_mouse = 1,

              sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

              touchpad     = {
                natural_scroll = false,
              },
            },
          })

          hl.gesture({
            fingers = 3,
            direction = "horizontal",
            action = "workspace"
          })

          -- Example per-device config
          -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
          hl.device({
            name        = "epic-mouse-v1",
            sensitivity = -0.5,
          })


          ---------------------
          ---- KEYBINDINGS ----
          ---------------------

          local mainMod = "SUPER" -- Sets "Windows" key as main modifier

          -- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
          -- for netrualizing kids
          --local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
          -- closeWindowBind:set_enabled(false)
          -- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
          hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("hyprshot -m region"))
          hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("wifi-menu"))
          hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("rofi-bluetooth"))
          hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
          hl.bind(mainMod .. "+ CTRL + E", hl.dsp.window.float({ action = "toggle" }))
          hl.bind(mainMod .. " + X", hl.dsp.window.move({ monitor = "+1" }))
          hl.bind("CTRL + B", hl.dsp.exec_cmd("kill -SIGUSR2 $(pidof waybar)"))
          hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
          hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd(terminal .. " --class=floatingkitty"))
          hl.bind(mainMod .. " + CTRL + C", hl.dsp.window.close())
          hl.bind("CTRL + Z", hl.dsp.window.fullscreen({mode = "maximized", action = "toggle"}))
          hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
          hl.bind("F1", hl.dsp.pass({ window = "class:^(TeamSpeak 3)$" }))
          hl.bind("F4", hl.dsp.pass({ window = "class:^(vesktop)$" }))
          hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
          hl.bind("XF86audioraisevolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
          hl.bind("xf86audiolowervolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
          hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))
          hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"))
          hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
          hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
          hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

          -- Move focus with mainMod + arrow keys
          hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
          hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
          hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
          hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

          -- Switch workspaces with mainMod + [0-9]
          -- Move active window to a workspace with mainMod + SHIFT + [0-9]
          for i = 1, 10 do
            local key = i % 10 -- 10 maps to key 0
            hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
            hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
          end

          -- Example special workspace (scratchpad)
          hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
          hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

          -- Scroll through existing workspaces with mainMod + scroll
          hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
          hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

          -- Move/resize windows with mainMod + LMB/RMB and dragging
          hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
          hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

          -- Laptop multimedia keys for volume and LCD brightness
          --hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
          --hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
          --hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
          --hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
          --hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
          --hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

          -- Requires playerctl
          hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
          hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
          hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
          hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


          --------------------------------
          ---- WINDOWS AND WORKSPACES ----
          --------------------------------

          -- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
          -- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

          -- Example window rules that are useful

          local suppressMaximizeRule = hl.window_rule({
            -- Ignore maximize requests from all apps. You'll probably like this.
            name           = "suppress-maximize-events",
            match          = { class = ".*" },

            suppress_event = "maximize",
          })
          -- suppressMaximizeRule:set_enabled(false)

          hl.window_rule({
            -- Fix some dragging issues with XWayland
            name     = "fix-xwayland-drags",
            match    = {
              class      = "^$",
              title      = "^$",
              xwayland   = true,
              float      = true,
              fullscreen = false,
              pin        = false,
            },

            no_focus = true,
          })

          -- Layer rules also return a handle.
          -- local overlayLayerRule = hl.layer_rule({
          --     name  = "no-anim-overlay",
          --     match = { namespace = "^my-overlay$" },
          --     no_anim = true,
          -- })
          -- overlayLayerRule:set_enabled(false)

          -- Hyprland-run window_rule
          hl.window_rule({
            name  = "move-hyprland-run",
            match = { class = "hyprland-run" },
            move  = "20 monitor_h-120",
            float = true,
          })

          hl.window_rule({
            name = "window_rule-1",
            float = true,
            match = { class = "floatingkitty" },
          })

          hl.window_rule({
            name = "window_rule-2",
            size = "monitor_w*0.45 monitor_h*0.45",
            match = { class = "floatingkitty", float = false },
          })

          hl.window_rule({
            name = "window_rule-3",
            workspace = 1,
            match = { class = "^firefox$" },
          })


          -- window_rule v2
          hl.window_rule({
            name = "window_rule-4",
            float = true,
            match = {
              class = "org.pulseaudio.pavucontrol",
              title = "Volume Control"
            }
          })

          hl.window_rule({
            name = "window_rule-5",
            float = true,
            size = "monitor_w*0.45 monitor_h*0.45",
            move = "1000 80",
            match = { class = "bluetui" }
          })


          hl.window_rule({
            name = "window_rule-6",
            float = true,
            size = "monitor_w*0.45 monitor_h*0.45",
            move = "1000 80",
            match = { class = "nmtui" }
          })


          hl.window_rule({
            name = "window_rule-7",
            float = true,
            size = "monitor_w*0.25 monitor_h*0.25",
            move = "1000 80",
            match = { title = "Volume Control" }
          })


          hl.window_rule {
            name = "window_rule-8",
            float = true,
            size = "monitor_w*0.25 monitor_h*0.25",
            move = "cursor_x-window_w*0.5   cursor_y-window_h*-0.5",
            match = { title = "Proton VPN" }
          }


          hl.window_rule {
            name = "window_rule-9",
            float = true,
            size = "monitor_w*0.45 monitor_h*0.45",
            move = "100 400",
            match = { class = "yazi" },
            animation = "popin",
          }


          hl.window_rule {
            name = "window_rule-10",
            float = true,
            size = "monitor_w*0.5 monitor_h*0.4",
            move = "100 100",
            match = { class = "Bitwarden" }
          }

          hl.window_rule {
            name = "window_rule-11",
            float = true,
            size = "monitor_w*0.3 monitor_h*0.3",
            match = { title = "VeraCrypt" },
          }


          hl.window_rule {
            name = "window_rule-13",
            float = true,
            size = "monitor_w*0.4 monitor_h*0.4",
            move = "400 670",
            match = { class = "microfetch" }
          }

          hl.window_rule {
            name = "games-workspace-move-steam",
            match = { class = "steam" },
            workspace = "7 silent"
          }


            hl.window_rule({
              name = "games-workspace-move",
              match = { xdg_tag = "^(proton-game)$" },
              workspace = "7 silent",
              float = true,
              fullscreen = true,
              content = "game",
            })


            hl.window_rule({
              name = "eve launcher",
              match = { title = "EVE Launcher", class = "steam_app_8500" },
              workspace = "special:magic",
              size = {1007, 600},
              move = {2, 35},
              float = true,
              content = "game",
            })

            hl.window_rule({
              name = "vesktop",
                workspace = "2" ,
              match = { class = "^vesktop" },
              })

            hl.window_rule({
              name = "float-games-workspace",
              match = {
                title = "negative:^(Steam|Friends List)$",
                xdg_tag = "negative:^(proton-game)$",
                workspace = "7" ,
              },

              size = { 1200, 1200 },
              center = true,
              float = true,
            })

      --      hl.window_rule({
      --        name = "hide-steam-windows",
      --        match = {
      --            title = "^Steam Settings$",
      --          class = "^steam$",
      --        },
      --        border_color = "rgb(fede22)",
      --        border_size = 3,
      --
      --        float = true,
      --        no_screen_share = true,
      --      })
    '';
  };
}
