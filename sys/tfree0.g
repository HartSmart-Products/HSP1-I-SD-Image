; tfree0.g
; called when tool 0 is freed

M98 P{directories.system^"/System Macros/Tool Change/tfree.g"}

if move.axes[0].homed
	G1 H2 X{global.x_park_position} F{global.rapid_speed}	; park the X carriage
