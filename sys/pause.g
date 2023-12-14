; pause.g
; called when a print from SD card is paused
M98 P"0:/sys/System Macros/State Recall/save_heaters.g"

M568 A1			; set current tool to standby
M83				; relative extrusion
G1 E-2 F3600	; retract 2mm
G91				; relative movement
G1 Z2 F500		; raise head 2mm
G90				; absolute movement
T-1				; deselect tool
