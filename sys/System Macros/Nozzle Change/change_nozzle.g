if exists(param.S) && exists(param.R) ; S=Tool, R=New nozzle diameter
	if param.S != 0 && param.S != 1
		abort "Invalid tool selected"
	M568 P{param.S} S0 R0 A0
	
	var tool = param.S == 0 ? "Left":"Right"
	var messageBoxTitle = "Changing the " ^ {var.tool} ^ " Nozzle"
	
	M291 P"Please run cleaning filament through the tool before switching nozzles if you haven't already." R{var.messageBoxTitle} S3
	M291 P"The printer will now home (if not already) and move the printhead into position." R{var.messageBoxTitle} S3
	
	if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
		M98 P"0:/sys/homeall.g"

	T-1
	G90
	if move.axes[2].machinePosition < 175
		G0 Z175 F{global.rapid_speed}
	G0 X{move.axes[0].min} Y10 U{move.axes[3].max}
	M400
	
	M568 P{param.S} S280
	M291 P{"Please wait while the " ^ var.tool ^ " tool is being heated up."} R{var.messageBoxTitle} T5 ; Display message
	T{param.S}
	
	G90
	G0 X{param.S == 0 ? 100:550} F{global.rapid_speed}
	M400
	
	M291 P"Loosen the nozzle and remove it, then press ""Ok"" to continue." R{var.messageBoxTitle} S2
	M291 P"Using the included torque wrench, install the new nozzle. Then press ""Ok"" to continue." R{var.messageBoxTitle} S2
	
	; Change nozzle diameter in config
	echo >{directories.system^"/Printer Parameters/Tool/t"^param.S^"_nozzle.g"} {"set global.t"^param.S^"_nozzle_diameter = "^param.R}
	M98 P{directories.system^"/Printer Parameters/Tool/t"^param.S^"_nozzle.g"}
	
	M291 P"Nozzle swap complete, parking the tool and turning it off." R{var.messageBoxTitle} S2
	T-1
	M568 P{param.S} S0 R0 A0
else
	echo "This macro is meant to be run through the parent macro"