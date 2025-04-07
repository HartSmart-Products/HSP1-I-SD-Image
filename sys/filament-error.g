; B: CAN address of board hosting the filament monitor
; D: Extruder #
; S: RRF error text

; P: Filament error type code
; 2: no data received
; 4: too little movement
; 5: too much movement
; 6: sensor error

if state.status != "processing" ; Don't run this from other macros right now.
	M99

var messageBoxTitle = "Filament Monitor Error"
var messageBoxContent = ""

if param.P == 2 ; A filament monitor is configured, but no data is being received from the monitor
	; Wiring issue
	set var.messageBoxContent = "The filament monitor is not reporting filament movement."
	M291 P{var.messageBoxContent} R{var.messageBoxTitle} S1 T0
elif param.P == 4 || param.P == 5 ; The movement is above or below the minimum set in the R value of M591
	set var.messageBoxTitle = "Filament Feeding Error"
	if param.P == 4
		; Filament could be out, there could be a jam, or the filament may be tangled. The LGX could also be jammed in an intermediate position, or the filament may be springy.
		set var.messageBoxContent = "The filament monitor has detected that the filament is not feeding enough. This may be caused by a jam or filament tangle."
	elif param.P == 5
		; Filament could be jammed and the LGX may be skipping. The filament may also be feeding poorly off the spool, or the filament may be springy.
		set var.messageBoxContent = "The filament monitor has detected that the filament is feeding too much. This may be caused by a jam or poor filament/spool condition."

	var tool_heater_set_point = 0

	if #tools[state.currentTool].active > 1
		set var.tool_heater_set_point = tools[state.currentTool].active[param.D]

	M25

	G90
	G1 H2 X{global.x_park_position} Y45 U{global.u_park_position} F{global.rapid_speed}	; Move to loading position
	M400

	T{param.D}
	if var.tool_heater_set_point > 0
		M568 S{var.tool_heater_set_point}
	M116 P{state.currentTool}

	var percentTotal = 0.0
	var extrudeSteps = 4
	var retries = 2
	var success = false

	while iterations <= var.retries
		G1 E-10 F1800                                                                      ; Unload
		G1 E12 F1200
		M591 D{param.D} A1
		G1 E5 F300

		set var.percentTotal = 0.0
		while iterations < var.extrudeSteps
			G1 E3 F300
			M400
			set var.percentTotal = sensors.filamentMonitors[param.D].lastPercentage + var.percentTotal

		M591 D{param.D} A0
		var percent = var.percentTotal/var.extrudeSteps

		if var.percent < sensors.filamentMonitors[param.D].configured.percentMin || var.percent > sensors.filamentMonitors[param.D].configured.percentMax
			echo "Failed", iterations + 1, "filament retry(s) with", var.percent, "percent total extrusion."
			continue
		else
			set var.success = true
			M24
			break
	
	if var.success
		echo "Filament error resolution succeeded, resuming..."
	else
		M291 P{var.messageBoxContent} R{var.messageBoxTitle} S1 T0
		echo "Filament error resolution failed:", var.messageBoxContent
		M568 P{param.D} A1

elif param.P == 6 ; one of the faults indicated by the LED flashes is present
	echo "4 flashes: I2C communications error"
	echo "5 flashes: I2C channel is in an incorrect state"
	echo "6 flashes: Magnet not detected"
	echo "7 flashes: Magnet too weak"
	echo "8 flashes: Magnet too strong"
	set var.messageBoxContent = "The filament monitor is reporting an error. Check the console for error codes"
	M291 P{var.messageBoxContent} R{var.messageBoxTitle} S1 T0
