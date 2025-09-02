; resume.g
; called before a print from SD card is resumed
M98 P"0:/sys/System Macros/State Recall/recall_heaters.g"

T-1
T R1                                 ; Reselect previous tool
if state.currentTool != -1
    M106 R1                          ; Reset fan speed to pre-pause speed
G90
G1 R1 X0 Y0 Z2 F{global.rapid_speed} ; move to 2mm above the resume location
G1 R1 X0 Y0 Z0 F{7.5*60}             ; move to the resume location
if state.currentTool != -1
    M83                              ; relative extruder movement
    G1 E2 F1800                      ; extrude 2mm

M400
