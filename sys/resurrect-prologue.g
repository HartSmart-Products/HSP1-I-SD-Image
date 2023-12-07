; Pre this file
; - Setpoints reset
; - Last tool is selected without running macros

M116									; wait for temperatures
M98 P{directories.system^"/homexyu.g"}	; home XYU, hope that Z hasn't moved

; Post this file
; - Babysteps reset to printing values, may be danger
; - Tool deselected without running macros
; - Last tool selected, running pre and post macros (wiping will happen)
; - Fans get reset
; - File position gets reset
; - Move back into position (no undo wipe retraction)
; - Restart the print
