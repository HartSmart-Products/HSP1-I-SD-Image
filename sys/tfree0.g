; tfree0.g
; called when tool 0 is freed

M568 P0 A1										; set tool to standby temp
M83												; relative extruder movement
G1 E-2 F2400									; retract 2mm
M106 S0											; turn off our print cooling fan
G91												; relative axis movement
G1 Z3 F500										; up 3mm
G90												; absolute axis movement
G1 H2 X{move.axes[0].min} F{global.rapid_speed}	; park the X carriage