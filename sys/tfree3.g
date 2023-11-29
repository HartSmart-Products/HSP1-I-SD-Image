; tfree3.g
; called when tool 3 is freed

M98 P{directories.system^"/System Macros/Tool Change/tfree.g"}

M579 U1				; un-invert U axis
if move.axes[0].homed && move.axes[0].homed
	G1 H2 X{move.axes[0].min} U{move.axes[3].max} F{global.rapid_speed}	; park the carriages
