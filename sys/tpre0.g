; tpre0.g
; called before tool 0 is selected
;

M98 P{directories.system^"/System Macros/Tool Change/tpre.g"}

if move.axes[3].homed
	G90
	G1 H2 U{global.u_park_position} F{global.rapid_speed}		; park the U carriage
