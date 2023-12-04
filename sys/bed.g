; bed.g
; called to perform automatic bed compensation via G32

M98 P{directories.system^"/System Macros/Change Settings/apply_babysteps.g"}

M561								; clear any bed transform

M401								; deploy probe
if global.probe_deployed == false	; check if the deploy macro completed successfully
	abort "Probe deploy error"
M564 H0								; allow moves without homing to home Z
G0 X{325.0-sensors.probes[0].offsets[0]} Y{300.0-sensors.probes[0].offsets[1]} F{global.rapid_speed}	; move to probe position
G30									; probe the bed and set Z height
M564 H1								; disallow moves without homing after Z is homed

; start of bed tramming moves
G30 P0 X30 Y80 Z-99999				; probe near a leadscrew
G30 P1 X30 Y600 Z-99999				; probe near a leadscrew
G30 P2 X600 Y600 Z-99999			; probe near a leadscrew
G30 P3 X600 Y80 Z-99999 S4			; probe near a leadscrew and calibrate 4 motors

; rehome Z
G0 X{325.0-sensors.probes[0].offsets[0]} Y{300.0-sensors.probes[0].offsets[1]} F{global.rapid_speed}	; move to probe position
G30									; probe the bed and set Z height
M402								; return probe to dock


