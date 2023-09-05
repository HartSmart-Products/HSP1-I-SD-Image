if exists(param.S) && exists(param.R)
	if global.t0_nozzle_diameter != param.S
		abort "Incorrect nozzle diameter in the Left tool! Expected " ^ param.S ^ " but " ^ global.t0_nozzle_diameter ^ " is configured."
	if global.t0_nozzle_diameter != param.R
		abort "Incorrect nozzle diameter in the Right tool! Expected " ^ param.R ^ " but " ^ global.t0_nozzle_diameter ^ " is configured."
elif exists(param.S)
	if global.t0_nozzle_diameter != param.S
		abort "Incorrect nozzle diameter in the Left tool! Expected " ^ param.S ^ " but " ^ global.t0_nozzle_diameter ^ " is configured."
	if global.t0_nozzle_diameter != param.S
		abort "Incorrect nozzle diameter in the Right tool! Expected " ^ param.S ^ " but " ^ global.t0_nozzle_diameter ^ " is configured."
else
	abort "No nozzle diameter passed to nozzle check macro"