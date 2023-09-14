if exists(param.S) && exists(param.R)
	if !exists(global.filament_loaded)
		global filament_loaded = false
	else
		set global.filament_loaded = false
	
	var messageBoxTitle = "Loading " ^ {param.R}
	M291 P"Please wait while the nozzle is being heated up" R{var.messageBoxTitle} T5 ; Display message 
	M568 S{param.S} A2	; Set current tool temperature to 205C
	M116				; Wait for the temperatures to be reached
	M291 P"Prepare filament for feeding" R{var.messageBoxTitle} S3
	M291 P"Feeding filament..." R{var.messageBoxTitle} T5 ; Display new message
	M83					; Extruder to relative mode
	G1 E40 F600			; Feed 850mm of filament at 600mm/min
	G1 E20 F300			; Feed 20mm of filament at 300mm/min
	;var correctColor = false
	;while !var.correctColor
	G1 E10 F300			; Feed 10mm of filament at 300mm/min
	;	M291 P"Is the filament extruding with the correct color?" R{var.messageBoxTitle} K{"Yes","No"} S4
	;	if input == "Yes"
	;		set correctColor = true
	G4 S2
	G1 E-10 F1200		; Retract 10mm of filament at 1200mm/min
	M82					; Extruder to absolute mode
	M400				; Wait for moves to complete
	M292				; Hide the message
	M568 A1				; Set tool to standby temps
	set global.filament_loaded = true
else
	echo "This macro is meant to be run as part of the Duet filament feature"