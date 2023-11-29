; tpre1.g
; called before tool 1 is selected

M98 P{directories.system^"/System Macros/Tool Change/tpre.g"}

if move.axes[0].homed
	G1 H2 X{move.axes[0].min} F{global.rapid_speed}	; park the X carriage
