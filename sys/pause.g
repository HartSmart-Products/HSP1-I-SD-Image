; pause.g
; called when a print from SD card is paused

M568 A1																; set current tool to standby
G91																	; relative movement
G1 Z2 F500															; raise head 2mm
G90																	; absolute movement
T-1
;G1 H2 X{move.axes[0].min} U{move.axes[3].max} F{global.rapid_speed}	; park both heads
