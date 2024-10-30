; S: Active temp setpoint
; F: Filament name

if exists(param.S) && exists(param.F)
	var messageBoxTitle = "Unloading " ^ {param.F}
	M291 P"Please wait while the nozzle is being heated up" R{var.messageBoxTitle} T5 ; Display message
	M568 S{param.S} A2                                                                ; Heat up the current tool
	M116 P{state.currentTool}                                                         ; Wait for the temperatures to be reached
	M291 P"Retracting filament..." R{var.messageBoxTitle} T5                          ; Display another message

	M591 D{state.currentTool} S0                                                      ; Disable filament monitor for feeding

	M83                                                                               ; Extruder to relative mode
	G1 E-20 F300                                                                      ; Retract 20mm of filament at 300mm/min
	G1 E-50 F1500                                                                     ; Retract 50mm of filament at 1500mm/min
	M82                                                                               ; Extruder to absolute mode
	M400                                                                              ; Wait for the moves to finish
	M292                                                                              ; Hide the message again
	M568 A1                                                                           ; Set tool to standby temps
	M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
	M291 P"Remove filament from machine" R{var.messageBoxTitle} S1

	set global.filament[state.currentTool] = ""
		
	var t0Filament = global.filament[0]
	var t1Filament = global.filament[1]
	
	echo >{directories.system^"/Printer Parameters/Tool/filament.g"} {"set global.filament = {"""^var.t0Filament^""","""^var.t1Filament^"""}"}

	M591 D{state.currentTool} S2                                                      ; Reenable filament monitor after feeding
else
	M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
	echo "This macro is meant to be run as part of the Duet filament feature"
