local function tablet_config(osu_mode)
	local osu_size = {84, 47.25}

	local function tablet_device(name, position, size)
		hl.device({
			name = name,
			output = main_monitor,
			region_size = {1920, 1080},
			region_position = {0, 0},
			active_area_position = position,
			active_area_size = size,
		})
	end

	tablet_device(
		"ugtablet-deco-01-stylus",
		osu_mode and {100, 40} or {0, 7.9375},
		osu_mode and osu_size or {254, 142.875}
	)

	tablet_device(
		"ugtablet-6-inch-pentablet",
		osu_mode and {47.040760869565, 27.537288135593} or {0, 6},
		osu_mode and osu_size or {178.08152173913044, 100.17085597826}
	)
end

tablet_config(false)

hl.on("window.open", function (w)
	if w.class == "osu!" then
		hl.notification.create({
			text = "Osu! tablet mode activated!",
			timeout = 4000,
			icon = "info"
		})
		tablet_config(true)
	end
end)

hl.on("window.close", function (w)
	if w.class == "osu!" then
		hl.notification.create({
			text = "Osu! tablet mode deactivated!",
			timeout = 4000,
			icon = "info"
		})
		tablet_config(false)
	end
end)
