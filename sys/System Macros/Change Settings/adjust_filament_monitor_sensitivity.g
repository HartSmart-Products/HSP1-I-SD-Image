; H - High tolerance
; L - Low tolerance
; D - Monitor to change
if exists(param.D) && exists(param.L) && exists(param.H)
	M591 D{param.D} R{param.L, param.H}
	set global.default_fm_override = true
else
	abort "No filament monitor adjustments or incomplete parameter set passed."
