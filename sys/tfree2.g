; tfree2.g
; called when tool 2 is freed

M208 X{global.x_max_travel} S0	; set axis maxima

M98 P{directories.system^"/System Macros/Tool Change/tfree.g"}

G1 H2 X{move.axes[0].min} U{move.axes[3].max} F{global.rapid_speed}	; park the carriages