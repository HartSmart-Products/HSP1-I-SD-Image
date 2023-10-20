if exists(param.S) && exists(param.R)
	if !exists(global.filament_loaded)
		global filament_loaded = false
	else
		set global.filament_loaded = false
	
	var messageBoxTitle = "Loading " ^ {param.R}
	M291 P"Please wait while the nozzle is being heated up" R{var.messageBoxTitle} T5 ; Display message 
	M568 S{param.S} A2			; Set current tool temperature to 205C
	M116 P{state.currentTool}	; Wait for the temperatures to be reached
	M291 P"Prepare filament for feeding" R{var.messageBoxTitle} S3
	M291 P"Feeding filament..." R{var.messageBoxTitle} T5 ; Display new message
	M83							; Extruder to relative mode
	G1 E40 F600					; Feed 40mm of filament
	G1 E50 F300					; Feed 50mm of filament
	;var correctColor = false
	;while !var.correctColor
	G1 E10 F300					; Feed 10mm of filament
	;	M291 P"Is the filament extruding with the correct color?" R{var.messageBoxTitle} K{"Yes","No"} S4
	;	if input == "Yes"
	;		set correctColor = true
	G4 S1
	G1 E-5 F1200				; Retract 5mm of filament
	M82							; Extruder to absolute mode
	M400						; Wait for moves to complete
	M292						; Hide the message
	M568 A1						; Set tool to standby temps
	;T-1 P0						; Deselect current tool
	set global.filament_loaded = true
else
	echo "This macro is meant to be run as part of the Duet filament feature"