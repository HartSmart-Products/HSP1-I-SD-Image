; homeall.g
; called to home all axes
;
M98 P"0:/sys/homexyu.g" 

M401									; deploy probe
if global.probe_deployed == false		; check if the deploy macro completed successfully
	abort "Probe deploy error"
G0 X330.0 Y330.0 F{global.rapid_speed}	; move to probe position
G30										; probe the bed and set Z height
M402									; return probe to dock
; Uncomment the following lines to lift Z after probing
;G91                    ; relative positioning
;G1 Z5 F500             ; lift Z relative to current position
;G90                    ; absolute positioning


