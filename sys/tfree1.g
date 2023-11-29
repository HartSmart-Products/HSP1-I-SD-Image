; tfree1.g
; called when tool 1 is freed

M98 P{directories.system^"/System Macros/Tool Change/tfree.g"}

if move.axes[3].homed
	G1 H2 U{move.axes[3].max} F{global.rapid_speed}		; park the U carriage
