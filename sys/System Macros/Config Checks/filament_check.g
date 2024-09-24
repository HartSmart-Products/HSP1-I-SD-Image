var messageBoxTitle = "Incorrect Filament"
var errorMessageLeft = ""
var errorMessageRight = ""

if exists(param.S)
	set var.errorMessageRight = "Incorrect filament loaded in the Right tool! Expected " ^ param.S ^ " but " ^ move.extruders[1].filament ^ " is loaded."

if exists(param.L)
	
	set var.errorMessageLeft = "Incorrect filament loaded in the Left tool! Expected " ^ param.L ^ " but " ^ move.extruders[0].filament ^ " is loaded."
	
	if exists(param.S)
		if move.extruders[1].filament != param.S
			M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
			M291 P{var.errorMessageRight} R{var.messageBoxTitle} S2
			abort var.errorMessageRight
	if move.extruders[0].filament != param.L
		M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
		M291 P{var.errorMessageLeft} R{var.messageBoxTitle} S2
		abort var.errorMessageLeft
	M99
	
if exists(param.S)
	if move.extruders[1].filament != param.S
		M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
		M291 P{var.errorMessageRight} R{var.messageBoxTitle} S2
		abort var.errorMessageRight
	M99

M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
abort "No filament type passed to the filament check macro"
