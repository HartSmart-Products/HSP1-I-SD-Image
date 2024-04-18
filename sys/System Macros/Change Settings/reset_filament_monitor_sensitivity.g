if global.default_fm_override
	M591 D0 R{global.default_fm_low, global.default_fm_high}
	M591 D1 R{global.default_fm_low, global.default_fm_high}
	set global.default_fm_override = false
