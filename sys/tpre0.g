; tpre0.g
; called before tool 0 is selected
;

M98 P{directories.system^"/System Macros/Tool Change/tpre.g"}
G1 H2 U{move.axes[3].max} F{global.rapid_speed}		; park the U carriage
