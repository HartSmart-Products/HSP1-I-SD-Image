; Pre this file
; - Set points reset
; - Last tool is selected without running macros
var selected_tool = state.currentTool

M116									; wait for temperatures
M98 P{directories.system^"/homexyu.g"}	; home XYU, hope that Z hasn't moved

if heat.heaters[0].active - heat.heaters[0].current > 10
	M568 P{var.selected_tool} A1		; set tool to standby temp
	M291 P"The machine lost power. During this time, the bed temperature dropped more than 10 degrees. Please confirm the part is still attached to the bed to continue." R"Auto Power Loss Recovery" S3
	M568 P{var.selected_tool} A2		; set tool to active temp
	M116								; wait for temperatures

T{var.selected_tool} P0					; reselect tool without running macros
M83 G1 E5 F1200							; undo retraction

; Post this file
; - Babysteps reset to printing values, may be danger
; - Tool deselected without running macros
; - Last tool selected, running pre and post macros (wiping will happen)
; - Fans get reset
; - File position gets reset
; - Move back into position (no undo wipe retraction)
; - Restart the print
