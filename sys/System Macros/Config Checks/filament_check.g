; L: Primary material (generic)
; S: Secondary material (generic)
; A: Primary material (specific)
; B: Secondary material (specific)

var messageBoxTitle = "Incorrect Filament"
var errorMessageLeft = ""
var filamentLeft = ""
var loadedLeft = ""
var errorMessageRight = ""
var filamentRight = ""
var loadedRight = ""

if exists(param.S) || exists(param.B)
	set var.filamentRight = exists(param.S)?param.S:param.B
	set var.loadedRight = exists(param.S)?move.extruders[1].filament:global.filament[1]
	set var.errorMessageRight = "Incorrect filament loaded in the Right tool! Expected " ^ var.filamentRight ^ " but " ^ var.loadedRight ^ " is loaded."

if exists(param.L) || exists(param.A)
	set var.filamentLeft = exists(param.L)?param.L:param.A
	set var.loadedLeft = exists(param.L)?move.extruders[0].filament:global.filament[0]
	set var.errorMessageLeft = "Incorrect filament loaded in the Left tool! Expected " ^ var.filamentLeft ^ " but " ^ var.loadedLeft ^ " is loaded."
	
	if var.filamentRight != ""
		if var.loadedRight != var.filamentRight
			M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
			M291 P{var.errorMessageRight} R{var.messageBoxTitle} S2
			abort var.errorMessageRight
	if var.loadedLeft != var.filamentLeft
		M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
		M291 P{var.errorMessageLeft} R{var.messageBoxTitle} S2
		abort var.errorMessageLeft
	M99
	
if var.filamentRight != ""
	if var.loadedRight != var.filamentRight
		M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
		M291 P{var.errorMessageRight} R{var.messageBoxTitle} S2
		abort var.errorMessageRight
	M99

M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
abort "No filament type passed to the filament check macro"
