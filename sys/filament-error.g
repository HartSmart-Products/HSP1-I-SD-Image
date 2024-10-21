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
	M99
elif param.P == 4 || param.P == 5 ; The movement is above or below the minimum set in the R value of M591
	set var.messageBoxTitle = "Filament Feeding Error"
	if param.P == 4
		; Filament could be out, there could be a jam, or the filament may be tangled. The LGX could also be jammed in an intermediate position, or the filament may be springy.
		set var.messageBoxContent = "The filament monitor has detected that the filament is not feeding enough. This may be caused by a jam or filament tangle."
	elif param.P == 5
		; Filament could be jammed and the LGX may be skipping. The filament may also be feeding poorly off the spool, or the filament may be springy.
		set var.messageBoxContent = "The filament monitor has detected that the filament is feeding too much. This may be caused by a jam or poor filament/spool condition."

	M25

	G90
	G1 H2 X{move.axes[0].min} Y45 U{move.axes[3].max} F{global.rapid_speed}	; Move to loading position
	M400

	T{param.D}

	var percentTotal = 0
	var extrudeSteps = 4

	G1 E-10 F1800			; Unload
	G1 E12 F1200
	while iterations < var.extrudeSteps
		G1 E3 F300
		M400
		set var.percentTotal = sensors.filamentMonitors[param.D].lastPercentage + var.percentTotal
		echo {"Percentage at stage "^iterations+1^":"}, sensors.filamentMonitors[param.D].lastPercentage
	
	var percent = var.percentTotal/var.extrudeSteps
	echo "Average percentage from extrusion attempts:", var.percent

	if var.percent < sensors.filamentMonitors[param.D].configured.percentMin || var.percent > sensors.filamentMonitors[param.D].configured.percentMax
		M291 P{var.messageBoxContent} R{var.messageBoxTitle} S1 T0
		M568 P{param.D} A1
	else
		M24

elif param.P == 6 ; one of the faults indicated by the LED flashes is present
    ; 4 flashes: I2C communications error
    ; 5 flashes: I2C channel is in an incorrect state
    ; 6 flashes: Magnet not detected.
    ; 7 flashes: Magnet too weak
    ; 8 flashes: Magnet too strong
	set var.messageBoxContent = "The filament monitor is reporting an error."
	M291 P{var.messageBoxContent} R{var.messageBoxTitle} S1 T0
	M99
