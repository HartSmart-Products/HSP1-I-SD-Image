; bed.g
; called to perform automatic bed compensation via G32

var messageBoxTitle = "True Bed Leveling"
var max_deviation = 0.02

M564 H0								; allow moves without homing to home the Z axis if required
M98 P{directories.system^"/homez.g"} S1
M564 H1								; disallow moves without homing after Z is homed

	
while true
	; start of bed tramming moves
	G30 P0 X30 Y80 Z-99999			; probe near a leadscrew
	G30 P1 X30 Y600 Z-99999			; probe near a leadscrew
	G30 P2 X600 Y600 Z-99999		; probe near a leadscrew
	G30 P3 X600 Y80 Z-99999 S4		; probe near a leadscrew and calibrate 4 motors
	
	; rehome Z
	G0 X{325.0-sensors.probes[0].offsets[0]} Y{300.0-sensors.probes[0].offsets[1]} F{global.rapid_speed}	; move to probe position
	G30								; probe the bed and set Z height
		
	if move.calibration.initial.deviation < var.max_deviation
		M291 P{"The bed has been leveled within " ^ move.calibration.initial.deviation ^ "mm between each corner."} R{var.messageBoxTitle} S1 T5
		break
	if iterations >= 5
		M291 P"Failed to level the bed within 5 iterations, something may be wrong." R{var.messageBoxTitle} S1 T5
		abort "Failed to level the bed within 5 iterations, something may be wrong."
		
M402								; return probe to dock
