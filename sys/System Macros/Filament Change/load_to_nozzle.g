; S: Active temp setpoint
; R: Standby temp setpoint
; F: Filament name
; B: Bed temp setpoint

if exists(param.S) && exists(param.F)
	if !exists(global.filament_loaded)
		global filament_loaded = false
	else
		set global.filament_loaded = false

	var messageBoxTitle = "Loading " ^ {param.F}
	var standbyTemperature = 100
	if exists(param.R)
		set var.standbyTemperature = params.R

	M568 S{param.S} R{var.standbyTemperature} A2                                      ; Set current tool temperature to 205C

	if exists(param.B)
		M400
		M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
		M291 P"Would you like to preheat the bed for this material?" R{var.messageBoxTitle} K{"Yes","No"} S4
		if input == 0
			M140 S{param.B}
	
	M400
	M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
	M291 P"Please keep hands clear while the machine moves to the loading position" R"Keep Hands Clear" S3 T300
	G90
	G1 H2 X{move.axes[0].min} Y45 U{move.axes[3].max} F{50 * 60}                      ; Move to a good loading location, slowly
	M400                                                                              ; Wait for moves to complete
	M291 P"Please wait while the nozzle is being heated up" R{var.messageBoxTitle} T5 ; Display message
	M116 P{state.currentTool}                                                         ; Wait for the temperatures to be reached
	M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
	M291 P"Prepare filament for feeding" R{var.messageBoxTitle} S3 T300
	M291 P"Feeding filament..." R{var.messageBoxTitle} T5                             ; Display new message
	M83                                                                               ; Extruder to relative mode
	G1 E40 F600                                                                       ; Feed 40mm of filament
	G1 E50 F300                                                                       ; Feed 50mm of filament
	var correctColor = false
	while !var.correctColor && param.F != "CLEANING"
		G1 E10 F300                                                                      ; Feed 10mm of filament
		M400                                                                             ; Wait for moves to complete
		M292                                                                             ; Hide previous messages
		M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
		M291 P"Is the filament extruding with the correct color/material?" R{var.messageBoxTitle} K{"Yes","No"} S4
		if input == 0
			set var.correctColor = true
	G4 S1
	G1 E-5 F1200                                                                      ; Retract 5mm of filament
	M82                                                                               ; Extruder to absolute mode
	M400                                                                              ; Wait for moves to complete
	M292                                                                              ; Hide previous messages
	M568 A1                                                                           ; Set tool to standby temps
	set global.filament_loaded = true
else
	M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
	echo "This macro is meant to be run as part of the Duet filament feature"

; New behavior
; Move toolhead to a good location for loading, then automatically wipe when done.
; Materials and settings to match PrusaSlicer
; Prompt for cleaning filament when switching from certain materials
