local cfg = "~/.config/hypr"
local spec_cfg = cfg.."/selected"

require("selected.monitors")
hl.env("MAIN_MONITOR", main_monitor)

hl.config({
	xwayland = {
		enabled = true,
		force_zero_scaling = true,
	}
})

local terminal = "kitty"
local file_manager = "pcmanfm-qt"
local menu = "hyprlauncher"

hl.env("XCURSOR_THEME", "cz-Hickson-Black")
hl.env("HYPRCURSOR_THEME", "cz-Hickson-Black")
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

hl.on("hyprland.start", function ()
	local waybar_json_cfg = spec_cfg.."/waybar.jsonc"
	local waybar_style = "~/.config/waybar/style.css"
	local waybar_cmd = "waybar -c "..waybar_json_cfg.." -s "..waybar_style

	hl.exec_cmd(waybar_cmd.."& swaync&")
	hl.exec_cmd("hyprpaper -c "..spec_cfg.."/paper.conf& hypridle& hyprlauncher -d&")

	require("selected.autostart")
end)

hl.config({
	group = {
		merge_groups_on_drag = false,
		col = {
			border_active = "rgba(edbeabaa)",
			border_inactive = "rgba(72634caa)",
		},
		groupbar = {
			font_size = 0,
			height = -8,
			indicator_height = 4,
			col = {
				active = "rgba(edbeabff)",
				inactive = "rgba(72634cff)",
				locked_active = "rgba(990000ff)",
				locked_inactive = "rgba(550000ff)",
			}
		}
	}
})

hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 2,
		border_size = 2,
		col = {
			active_border = {
				colors = {"rgba(eac4c9aa)"},
				angle = 45
			},
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		blur = {
			enabled = true,
			size = 3,
			passes = 4,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = true
	}
})

hl.curve("my_bezier", {type = "bezier", points = {{0.05, 0.9}, {0.1, 1.05}}})
hl.animation({leaf = "windows", enabled = true, speed = 7, bezier = "my_bezier"})
hl.animation({
	leaf = "windowsOut", enabled = true, speed = 7, bezier = "default",
	style = "popin 80%"
})
hl.animation({leaf = "border", enabled = true, speed = 10, bezier = "default"})
hl.animation({leaf = "borderangle", enabled = true, speed = 8, bezier = "default"})
hl.animation({leaf = "fade", enabled = true, speed = 7, bezier = "default"})
hl.animation({leaf = "workspaces", enabled = true, speed = 6, bezier = "default"})

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master"
	}
})

hl.config({
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false
	}
})

hl.config({
	input = {
		kb_layout = "us,ru,ua",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:caps_toggle",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			disable_while_typing = false,
			natural_scroll = false,
		}
	}
})

require("tablet")

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace"
})

hl.device({
	name = "ugtablet-deco-01-keyboard",
	enabled = false
})

local main_mod = "SUPER"

hl.bind(main_mod.." + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(main_mod.." + M", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))

hl.bind(main_mod.." + R", hl.dsp.exec_cmd(menu))
hl.bind(main_mod.." + Q", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod.." + E", hl.dsp.exec_cmd(file_manager))

hl.bind(main_mod.." + V", hl.dsp.window.float({action = "toggle"}))
hl.bind(main_mod.." + F", hl.dsp.window.fullscreen())
hl.bind(main_mod.." + SHIFT + W", hl.dsp.window.pin())
hl.bind(main_mod.." + C", hl.dsp.window.close())
hl.bind(main_mod.." + J", hl.dsp.layout("togglesplit"))

hl.bind(
	main_mod.." + SHIFT + left",
	hl.dsp.window.move({x = -10, y = 0, relative = true}),
	{repeating = true}
)
hl.bind(
	main_mod.." + SHIFT + right",
	hl.dsp.window.move({x = 10, y = 0, relative = true}),
	{repeating = true}
)
hl.bind(
	main_mod.." + SHIFT + up",
	hl.dsp.window.move({x = 0, y = -10, relative = true}),
	{repeating = true}
)
hl.bind(
	main_mod.." + SHIFT + down",
	hl.dsp.window.move({x = 0, y = 10, relative = true}),
	{repeating = true}
)

hl.bind(
	main_mod.." + CTRL + left",
	hl.dsp.window.resize({x = -10, y = 0, relative = true}),
	{repeating = true}
)
hl.bind(
	main_mod.." + CTRL + right",
	hl.dsp.window.resize({x = 10, y = 0, relative = true}),
	{repeating = true}
)
hl.bind(
	main_mod.." + CTRL + up",
	hl.dsp.window.resize({x = 0, y = -10, relative = true}),
	{repeating = true}
)
hl.bind(
	main_mod.." + CTRL + down",
	hl.dsp.window.resize({x = 0, y = 10, relative = true}),
	{repeating = true}
)

hl.bind(main_mod.." + SHIFT + CTRL + left", hl.dsp.window.swap({direction = "left"}))
hl.bind(main_mod.." + SHIFT + CTRL + right", hl.dsp.window.swap({direction = "right"}))
hl.bind(main_mod.." + SHIFT + CTRL + up", hl.dsp.window.swap({direction = "up"}))
hl.bind(main_mod.." + SHIFT + CTRL + down", hl.dsp.window.swap({direction = "down"}))

hl.bind(main_mod.." + left", hl.dsp.focus({direction = "left"}))
hl.bind(main_mod.." + right", hl.dsp.focus({direction = "right"}))
hl.bind(main_mod.." + up", hl.dsp.focus({direction = "up"}))
hl.bind(main_mod.." + down", hl.dsp.focus({direction = "down"}))

for i = 1, 10 do
	local key = i % 10
	hl.bind(main_mod.." + "..key, hl.dsp.focus({workspace = i}))
	hl.bind(main_mod.." + SHIFT + "..key, hl.dsp.window.move({workspace = i}))
end

hl.bind(main_mod.." + SPACE", hl.dsp.workspace.toggle_special("system"))
hl.bind(main_mod.." + SHIFT + SPACE", hl.dsp.window.move({workspace = "special:system"}))

hl.bind(main_mod.." + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main_mod.." + SHIFT + S", hl.dsp.window.move({workspace = "special:magic"}))

hl.bind(main_mod.." + T", hl.dsp.workspace.toggle_special("chats"))
hl.bind(main_mod.." + SHIFT + T", hl.dsp.window.move({workspace = "special:chats"}))

hl.bind(main_mod.." + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod.." + mouse:273", hl.dsp.window.resize(), { mouse = true })

require("selected.binds")

hl.bind(main_mod.." + P", hl.dsp.exec_cmd("systemctl suspend"))

hl.bind(
	"CTRL + SHIFT + E",
	hl.dsp.exec_cmd("hyprctl switchxkblayout "..require("selected.keyboard").." 0"),
	{locked = true}
)

local function screenshot(type)
	return hl.dsp.exec_cmd("hyprshot --clipboard-only -z -m "..type)
end
hl.bind("PRINT", screenshot("region"))
hl.bind(main_mod.." + PRINT", screenshot("window"))
hl.bind(main_mod.." + SHIFT + PRINT", screenshot("output"))

local function color()
	local select_cmd = "hyprlauncher -o \"cmyk,hex,rgb,hsl,hvs\""
	local get_color = "hyprpicker -a -f $("..select_cmd.." && sleep 0.5)"
	return hl.dsp.exec_cmd(get_color)
end
hl.bind(main_mod.." + CTRL + PRINT", color())

hl.bind(main_mod.." + G", hl.dsp.group.toggle())
hl.bind(main_mod.." + SHIFT + G", hl.dsp.group.lock_active({toggle = true}))
hl.bind(main_mod.." + CTRL + G", hl.dsp.window.move({out_of_group = true}))
hl.bind(main_mod.." + Z", hl.dsp.group.prev())
hl.bind(main_mod.." + X", hl.dsp.group.next())
