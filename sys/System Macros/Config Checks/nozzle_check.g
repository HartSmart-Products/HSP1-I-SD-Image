var messageBoxTitle = "Incorrect Nozzle"

if exists(param.L)
	if exists(param.S)
		if global.t1_nozzle_diameter != param.S
			M291 P{"Incorrect nozzle diameter in the Right tool! Expected " ^ param.S ^ " but " ^ global.t1_nozzle_diameter ^ " is configured."} R{var.messageBoxTitle} S2
			abort
	if global.t0_nozzle_diameter != param.L
		M291 P{"Incorrect nozzle diameter in the Left tool! Expected " ^ param.L ^ " but " ^ global.t0_nozzle_diameter ^ " is configured."} R{var.messageBoxTitle} S2
		abort
	M99
	
if exists(param.S)
	if global.t1_nozzle_diameter != param.S
		M291 P{"Incorrect nozzle diameter in the Right tool! Expected " ^ param.S ^ " but " ^ global.t1_nozzle_diameter ^ " is configured."} R{var.messageBoxTitle} S2
		abort
	M99

abort "No nozzle diameter passed to nozzle check macro"
