if exists(param.T) && exists(param.N) ; T=Tool, N=New nozzle diameter
	if param.T != 0 && param.T != 1
		abort "Invalid tool selected"
	M568 P{param.T} S0 R0 A0
	
	var tool = param.T == 0 ? "Left":"Right"
	var messageBoxTitle = "Changing the " ^ {var.tool} ^ " Nozzle"

	M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
	M291 P"The printer will now home (if not already)." R{var.messageBoxTitle} S3

	if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed || !move.axes[3].homed
		M98 P"0:/sys/homeall.g"

	M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}

	if move.extruders[param.T].filament != ""
		M291 P"Filament is detected as loaded. We recommend unloading and running cleaning filament through. Would you like to do that now?" R{var.messageBoxTitle} K{"Yes","Unload Only"} S4 J1
		
		T{param.T}
		M116 P{state.currentTool}
		M702
	else
		M291 P"We recommend running cleaning filament through before switching nozzles. Would you like to do that now?" R{var.messageBoxTitle} K{"Yes","No"} S4 J1

	if input == 0
		T{param.T}
		M116 P{state.currentTool}
		M701 S"CLEANING"
		M702
		M400

	M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
	M291 P"The printer will now move the tool into a park position and present it when ready." R{var.messageBoxTitle} S3

	T-1
	G90
	if move.axes[2].machinePosition < 175
		G0 Z175 F{global.rapid_speed}
	G0 X{global.x_park_position} Y10 U{global.u_park_position} F{global.safe_speed}
	M400
	
	M568 P{param.T} S280
	M291 P{"Please wait while the " ^ var.tool ^ " tool is being heated up."} R{var.messageBoxTitle} T5 ; Display message
	T{param.T}
	M116 P{state.currentTool}
	
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
