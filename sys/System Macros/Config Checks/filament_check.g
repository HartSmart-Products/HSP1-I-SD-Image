if exists(param.S)
	if exists(param.R)
		if move.extruders[1].filament != param.R
			abort "Incorrect filament loaded in the Right tool! Expected " ^ param.R ^ " but " ^ move.extruders[1].filament ^ " is loaded."
	if move.extruders[0].filament != param.S
		abort "Incorrect filament loaded in the Left tool! Expected " ^ param.S ^ " but " ^ move.extruders[0].filament ^ " is loaded."
	M99
	
if exists(param.R)
	if move.extruders[1].filament != param.R
		abort "Incorrect filament loaded in the Right tool! Expected " ^ param.R ^ " but " ^ move.extruders[1].filament ^ " is loaded."
	M99

abort "No filament type passed to the filament check macro"
