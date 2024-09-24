var messageBoxTitle = "Incorrect Nozzle"
var errorMessageLeft = ""
var errorMessageRight = ""

if exists(param.S)
	set var.errorMessageRight = "Incorrect nozzle diameter in the Right tool! Expected " ^ param.S ^ " but " ^ global.t1_nozzle_diameter ^ " is configured."	

if exists(param.L)
	set var.errorMessageLeft = "Incorrect nozzle diameter in the Left tool! Expected " ^ param.L ^ " but " ^ global.t0_nozzle_diameter ^ " is configured."

	if exists(param.S)
		if global.t1_nozzle_diameter != param.S
			M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
			M291 P{var.errorMessageRight} R{var.messageBoxTitle} S2
			abort var.errorMessageRight
	if global.t0_nozzle_diameter != param.L
		M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
		M291 P{var.errorMessageLeft} R{var.messageBoxTitle} S2
		abort var.errorMessageLeft
	M99
	
if exists(param.S)
	if global.t1_nozzle_diameter != param.S
		M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
		M291 P{var.errorMessageRight} R{var.messageBoxTitle} S2
		abort var.errorMessageRight
	M99

M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
abort "No nozzle diameter passed to nozzle check macro"
