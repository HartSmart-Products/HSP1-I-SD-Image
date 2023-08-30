; tfree1.g
; called when tool 1 is freed

M568 P1 A1											; set tool to standby temp
M83													; relative extruder movement
G1 E-2 F3600										; retract 2mm
M106 S0												; turn off our print cooling fan
G91													; relative axis movement
G1 Z3 F500											; up 3mm
G90													; absolute axis movement
G1 H2 U{move.axes[3].max} F{global.rapid_speed}		; park the U carriage