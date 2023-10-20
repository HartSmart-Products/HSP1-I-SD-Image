if exists(param.S) && exists(param.R) ; S=Tool, R=New nozzle diameter
	M568 P{param.S} S0 R0 A0
	
	var tool = param.R == 1 ? "Left":"Right"
	var messageBoxTitle = "Changing the " ^ {var.tool} ^ " Nozzle"
	
	; Behavior: Home (if not), then move toolhead to accessible location for nozzle change. Heat up, prompt swap (probably with a timeout), then cool down and deactivate tool.
	
	M291 P"Please run cleaning filament through the tool before switching nozzles if you haven't already." R{var.messageBoxTitle} S3
	M291 P"The printer will now home (if not already) and move the printhead into position." R{var.messageBoxTitle} S3
	
	if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
		M98 P"0:/sys/homeall.g"

	T-1
	G90
	G0 Z175 F{global.rapid_speed}
	G0 X{move.axes[0].min} Y10 U{move.axes[3].max}
	M400
	
	M568 P{param.S} S260
	M291 P{"Please wait while the " ^ var.tool ^ " tool is being heated up."} R{var.messageBoxTitle} T5 ; Display message
	T{param.S}
	
	G90
	G0 X{param.R == 1 ? 50:600} F{global.rapid_speed}
	M400
	
	M291 P"Loosen the nozzle and remove it, then press ""Ok"" to continue." R{var.messageBoxTitle} S2
	M291 P"Using the included torque wrench, install the new nozzle. Then press ""Ok"" to continue." R{var.messageBoxTitle} S2
	
	M291 P"Nozzle swap complete, parking the tool and turning it off." R{var.messageBoxTitle} S2
	T-1
	M568 P{param.S} S0 R0 A0
else
	echo "This macro is meant to be run through the parent macro"