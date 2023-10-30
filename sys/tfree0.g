; tfree0.g
; called when tool 0 is freed

M98 P{directories.system^"/System Macros/Tool Change/tfree.g"}

G1 H2 X{move.axes[0].min} F{global.rapid_speed}	; park the X carriage
