local function player(cmd)
	return hl.dsp.exec_cmd("playerctl "..cmd)
end

hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"),
	{ locked = true }
)

hl.bind("Help", player("play-pause"), { locked = true })
hl.bind("XF86HangupPhone", player("next"), { locked = true })
hl.bind("XF86PickupPhone", player("previous"), { locked = true })
hl.bind("XF86Calculator", player("stop"), { locked = true })

local function set_brightness(s)
	local gpu = "amdgpu_bl0"
	return hl.dsp.exec_cmd("brightnessctl -d "..gpu.." set 5%"..s)
end

hl.bind("XF86MonBrightnessUp", set_brightness("+"), { locked = true })
hl.bind("XF86MonBrightnessDown", set_brightness("-"), { locked = true })
