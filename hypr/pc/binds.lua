local function player(cmd)
	return hl.dsp.exec_cmd("playerctl "..cmd)
end

hl.bind("XF86AudioPlay", player("play-pause"), { locked = true })
hl.bind("XF86AudioNext", player("next"), { locked = true })
hl.bind("XF86AudioPrev", player("previous"), { locked = true })
hl.bind("XF86AudioStop", player("stop"), { locked = true })
