var messageBoxTitle = "Incorrect Filament"

if exists(param.S)
	if exists(param.R)
		if move.extruders[1].filament != param.R
			M291 P{"Incorrect filament loaded in the Right tool! Expected " ^ param.R ^ " but " ^ move.extruders[1].filament ^ " is loaded."} R{var.messageBoxTitle} S2
			abort
	if move.extruders[0].filament != param.S
		M291 P{"Incorrect filament loaded in the Left tool! Expected " ^ param.S ^ " but " ^ move.extruders[0].filament ^ " is loaded."} R{var.messageBoxTitle} S2
		abort
	M99
	
if exists(param.R)
	if move.extruders[1].filament != param.R
		M291 P{"Incorrect filament loaded in the Right tool! Expected " ^ param.R ^ " but " ^ move.extruders[1].filament ^ " is loaded."} R{var.messageBoxTitle} S2
		abort
	M99

abort "No filament type passed to the filament check macro"
