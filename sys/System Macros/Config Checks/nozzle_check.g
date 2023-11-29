var messageBoxTitle = "Incorrect Nozzle"

if exists(param.S)
	if exists(param.R)
		if global.t1_nozzle_diameter != param.R
			M291 P{"Incorrect nozzle diameter in the Right tool! Expected " ^ param.R ^ " but " ^ global.t1_nozzle_diameter ^ " is configured."} R{var.messageBoxTitle} S2
			abort
	if global.t0_nozzle_diameter != param.S
		M291 P{"Incorrect nozzle diameter in the Left tool! Expected " ^ param.S ^ " but " ^ global.t0_nozzle_diameter ^ " is configured."} R{var.messageBoxTitle} S2
		abort
	M99
	
if exists(param.R)
	if global.t1_nozzle_diameter != param.R
		M291 P{"Incorrect nozzle diameter in the Right tool! Expected " ^ param.R ^ " but " ^ global.t1_nozzle_diameter ^ " is configured."} R{var.messageBoxTitle} S2
		abort
	M99

abort "No nozzle diameter passed to nozzle check macro"
