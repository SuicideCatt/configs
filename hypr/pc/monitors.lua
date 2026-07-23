main_monitor = "HDMI-A-1"

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "1080x523",
	scale = 1,
	bitdepth = 10,
})

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@60",
	position = "3000x523",
	scale = 1,
	bitdepth = 10,
})

hl.monitor({
	output = "DP-3",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
	transform = 1,
	bitdepth = 10,
})

hl.workspace_rule({
	workspace = "1",
	monitor = "HDMI-A-1",
	default = true,
})
hl.workspace_rule({
	workspace = "4",
	monitor = "HDMI-A-1",
})
hl.workspace_rule({
	workspace = "5",
	monitor = "HDMI-A-1",
})


hl.workspace_rule({
	workspace = "2",
	monitor = "DP-2",
})
hl.workspace_rule({
	workspace = "6",
	monitor = "DP-2",
})
hl.workspace_rule({
	workspace = "7",
	monitor = "DP-2",
})

hl.workspace_rule({
	workspace = "3",
	monitor = "DP-3",
})
