main_monitor = "eDP-1"

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
})


hl.workspace_rule({
	workspace = "1",
	monitor = "eDP-1",
	default = true,
})

hl.config({
	debug = {
		disable_scale_checks = true
	}
})
