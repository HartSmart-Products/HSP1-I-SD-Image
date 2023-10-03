; resume.g
; called before a print from SD card is resumed

T R1						; Reselect previous tool
M568 A2						; set current tool to active temps
M116 P{state.currentTool}	; wait for active tool heaters to reach operating temperature
G1 R1 X0 Y0 Z2 F5000		; move to 2mm above the resume location
G1 R1 X0 Y0 Z0 F500			; move to the resume location
M83							; relative extrusion
G1 E2 F3600					; undo the retraction
