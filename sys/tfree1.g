; tfree1.g
; called when tool 1 is freed

M98 P"0:/sys/System Macros/Tool Change/tfree.g"

G1 H2 U{move.axes[3].max} F{global.rapid_speed}		; park the U carriage