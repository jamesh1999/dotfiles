--------------------------------------------------
-- MONITORS
--------------------------------------------------
hl.monitor({ output = "DP-2", mode = "3840x2160@160", position = "0x0", scale = 1.5, bitdepth = 10, vrr = 2 })
hl.monitor({ output = "DP-3", mode = "3840x2160@160", position = "2560x0", scale = 1.5, bitdepth = 10, vrr = 2 })
hl.monitor({ output = "HDMI-A-1", mode = "1600x1200@60", position = "0x0", scale = 1 })

hl.config({
	xwayland = {
		force_zero_scaling = true,
	}
})


--------------------------------------------------
-- PROGRAMS
--------------------------------------------------
local terminal = "alacritty"
local fileManager = "dolphin"
local notifications = "swaync-client -t"
local menu = 'rofi -show drun -run-command "uwsm app -- {cmd}"'
local emoji = "rofi -show emoji -modi emoji"
local clipboard = "cliphist list | rofi -modi clipboard:cliphist-rofi-img.sh -show clipboard -show-icons | cliphist decode | wl-paste"


--------------------------------------------------
-- AUTOSTART
--------------------------------------------------
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd('tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"')

	-- hl.exec_cmd("nm-applet")
end)


--------------------------------------------------
-- LOOK AND FEEL
--------------------------------------------------
hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 18,

		border_size = 1,
		col = {
			active_border = { colors = { "rgba(3aabffee)", "rgba(ffa51dee)" }, angle = 45 },
			inactive_border = "rgba(333333ff)",
		},

		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	}
})

hl.config({
	decoration = {
		rounding = 1,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 1.0,
		dim_inactive = true,
		dim_strength = 0.1,

		shadow = {
			enabled = true,
			range = 20,
			render_power = 3,
			sharp = false,
			color = "rgba(080808bb)",
			color_inactive = "rgba(00000000)",
		},

		blur = {
			enabled = true,
			size = 5,
			passes = 2,
			ignore_opacity = true,
			new_optimizations = true,
		}
	}
})

hl.config({
	animations = {
		enabled = true, -- yes, please :)
	}
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
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

hl.animation({ leaf = "borderangle", enabled = true, speed = 60, bezier = "linear", style = "loop" })

hl.config({
	dwindle = {
		preserve_split = true,
		smart_split = true,
	}
})

hl.config({
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	}
})

hl.config({
	misc = {
		disable_hyprland_logo = true,
		key_press_enables_dpms = true,
	}
})

hl.config({
	quirks = {
		prefer_hdr = 2,
	}
})


--------------------------------------------------
-- PLUGINS
--------------------------------------------------
-- The nil check avoids an error if the plugin hasn't been loaded yet
-- (it gets picked up on the next config reload once hyprpm has loaded it).
if hl.plugin.overview ~= nil then
	hl.config({
		plugin = {
			overview = {
				affectStrut = false,
				showEmptyWorkspace = false,
			}
		}
	})
end


--------------------------------------------------
-- INPUT
--------------------------------------------------
hl.config({
	input = {
		kb_layout = "gb",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 2,
		float_switch_override_focus = 0,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		}
	}
})

hl.device({
	name = "tablet-monitor-pen",
	transform = 0,
	output = "current",
})


--------------------------------------------------
-- KEYBINDINGS
--------------------------------------------------
local mainMod = "SUPER"

hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("powermenu.sh"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("PRINT", hl.dsp.exec_cmd("screenshot.sh"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("screenshot.sh -u"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("uwsm app -- " .. terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- " .. fileManager))
hl.bind(mainMod .. " + G", hl.dsp.window.float())
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. " + SUPER_L", hl.dsp.exec_cmd("uwsm app -- " .. menu), { release = true })
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd(emoji))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(notifications))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
-- hl.bind(mainMod .. " + W", hl.dsp.overview("toggle"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = "1", on_current_monitor = true }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = "2", on_current_monitor = true }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = "3", on_current_monitor = true }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = "4", on_current_monitor = true }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = "5", on_current_monitor = true }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = "6", on_current_monitor = true }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = "7", on_current_monitor = true }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = "8", on_current_monitor = true }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = "9", on_current_monitor = true }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Example special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = false }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Disable keybinds
hl.bind(mainMod .. " + Z", hl.dsp.submap("disabled"))
hl.define_submap("disabled", function()
	hl.bind(mainMod .. " + ESCAPE", hl.dsp.submap("reset"))
end)


--------------------------------------------------
-- WINDOWS AND WORKSPACES
--------------------------------------------------
hl.window_rule({ match = { class = "gamescope" }, monitor = "DP-2" })
hl.window_rule({ match = { class = "gamescope" }, workspace = "10" })

hl.window_rule({ match = { class = "spotify|discord" }, workspace = "special:magic" })

hl.window_rule({ match = { class = [[^org\.freedesktop\.impl\.portal\.desktop\.kde$]] }, float = true })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true })

hl.window_rule({ match = { class = [[.*]] }, suppress_event = "maximize" }) -- Ignore maximise requests
hl.window_rule({
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.workspace_rule({ workspace = "10", monitor = "DP-2" })

hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true })

hl.layer_rule({ match = { namespace = "rofi" }, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, ignore_alpha = 0.5 })

hl.config({
	debug = {
		full_cm_proto = false,
	}
})
