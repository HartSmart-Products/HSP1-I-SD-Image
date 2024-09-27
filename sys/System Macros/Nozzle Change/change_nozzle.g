if exists(param.T) && exists(param.N) ; T=Tool, N=New nozzle diameter
	if param.T != 0 && param.T != 1
		abort "Invalid tool selected"
	M568 P{param.T} S0 R0 A0
	
	var tool = param.T == 0 ? "Left":"Right"
	var messageBoxTitle = "Changing the " ^ {var.tool} ^ " Nozzle"
	
	M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
	M291 P"Please run cleaning filament through the tool before switching nozzles if you haven't already." R{var.messageBoxTitle} S3
	M291 P"The printer will now home (if not already) and move the printhead into position." R{var.messageBoxTitle} S3
	
	if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
		M98 P"0:/sys/homeall.g"

	T-1
	G90
	if move.axes[2].machinePosition < 175
		G0 Z175 F{global.rapid_speed}
	G0 X{move.axes[0].min} Y10 U{move.axes[3].max} F{global.safe_speed}
	M400
	
	M568 P{param.T} S280
	M291 P{"Please wait while the " ^ var.tool ^ " tool is being heated up."} R{var.messageBoxTitle} T5 ; Display message
	T{param.T}
	
	G90
	G0 X{param.T == 0 ? 100:550} F{global.safe_speed} 
	M400
	
	M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
	M291 P"Loosen the nozzle and remove it, then press ""Ok"" to continue." R{var.messageBoxTitle} S2
	M291 P"Using the included torque wrench, install the new nozzle. Then press ""Ok"" to continue." R{var.messageBoxTitle} S2
	
	; Change nozzle diameter in config
	echo >{directories.system^"/Printer Parameters/Tool/t"^param.T^"_nozzle.g"} {"set global.t"^param.T^"_nozzle_diameter = "^param.N}
	M98 P{directories.system^"/Printer Parameters/Tool/t"^param.T^"_nozzle.g"}
	
	M98 P{directories.system^"/System Macros/Alert Sounds/success.g"}
	M291 P"Nozzle swap complete, parking the tool and turning it off." R{var.messageBoxTitle} S2
	T-1
	M568 P{param.T} S0 R0 A0
else
	M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
	echo "This macro is meant to be run through the parent macro"
