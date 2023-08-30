; tfree2.g
; called when tool 2 is freed

M208 X{global.x_max_travel} S0	; set axis maxima
M568 P2 A1						; set tool to standby temp
M83								; relative extruder movement
G1 E-2 F3600					; retract 2mm
M106 S0							; turn off our print cooling fan
G91								; relative axis movement
G1 Z3 F500						; up 3mm
G90								; absolute axis movement
G1 H2 X{move.axes[0].min} U{move.axes[3].max} F{global.rapid_speed}	; park the carriages