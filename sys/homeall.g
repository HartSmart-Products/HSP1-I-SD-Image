; homeall.g
; called to home all axes
;
M98 P{directories.system^"/homexyu.g"}

M401									; deploy probe
if global.probe_deployed == false		; check if the deploy macro completed successfully
	abort "Probe deploy error"
G0 X{325.0-sensors.probes[0].offsets[0]} Y{320.0-sensors.probes[0].offsets[1]} F{global.rapid_speed}	; move to probe position
G30										; probe the bed and set Z height
M402									; return probe to dock
; Uncomment the following lines to lift Z after probing
;G91                    ; relative positioning
;G1 Z5 F500             ; lift Z relative to current position
;G90                    ; absolute positioning


