M568 P{state.currentTool} A1	; set tool to standby temp
M83								; relative extruder movement
G1 E-2 F2400					; retract 2mm
M106 S0							; turn off our print cooling fan
G91								; relative axis movement
G1 Z3 F500						; up 3mm
G90								; absolute axis movement