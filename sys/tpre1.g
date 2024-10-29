; tpre1.g
; called before tool 1 is selected

M98 P{directories.system^"/System Macros/Tool Change/tpre.g"}

if move.axes[0].homed
	G90
	G1 H2 X{global.x_park_position} F{global.rapid_speed}	; park the X carriage
