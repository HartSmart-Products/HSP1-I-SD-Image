if exists(param.S)
	if exists(param.R)
		if global.t1_nozzle_diameter != param.R
			abort "Incorrect nozzle diameter in the Right tool! Expected " ^ param.R ^ " but " ^ global.t1_nozzle_diameter ^ " is configured."
	if global.t0_nozzle_diameter != param.S
		abort "Incorrect nozzle diameter in the Left tool! Expected " ^ param.S ^ " but " ^ global.t0_nozzle_diameter ^ " is configured."
	M99
	
if exists(param.R)
	if global.t1_nozzle_diameter != param.R
		abort "Incorrect nozzle diameter in the Right tool! Expected " ^ param.R ^ " but " ^ global.t1_nozzle_diameter ^ " is configured."
	M99

abort "No nozzle diameter passed to nozzle check macro"
