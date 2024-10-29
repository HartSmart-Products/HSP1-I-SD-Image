; Macro to aid with setting tool XY Offsets
var macro_title = "Tool XY Offset Calibration"
var z_focus_height = 38
var x_base_point = 325
var y_base_point = 75
var t1_x_offset = 0
var t1_y_offset = 0

; Make sure the bed isn't hot as to not damage the camera
if heat.heaters[0].current > 35
	M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
	M291 P"The build plate is too hot to run this macro. Please turn it off and wait until it is below 35 degrees." R{var.macro_title} S2
	abort

; Ask to Home XYU+Z if not homed, then move the left tool into calibration position (don't select it)
M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
M291 P"This Macro will assist with calibrating the tool XY offsets. The machine will now home and move the tools for calibration. Please confirm the bed is clear and no collisions will result." R{var.macro_title} S3

T-1
G28                                           ; Home the machine

G29 S2                                        ; Ensure mesh compensation is off
M290 R0 S0                                    ; Clear babystepping
G90
G0 Z{var.z_focus_height} F{global.safe_speed} ; Position tools as focal point
G0 X{var.x_base_point} Y{var.y_base_point}    ; Move the left tool to position
M400                                          ; Wait for moves to finish

; Ask the user to position the CXC on the bed using the alignment guide
M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
M291 P"For the following steps, use the smaller display for this macro and the larger display to view the camera." R{var.macro_title} S2
M291 P"Plug the CXC into one of the ports on the side of the machine and open <a href=""https://emberprototypes.github.io/"" target=""_blank"">the CXC online tool</a>." R{var.macro_title} S3

; Ask the user to align the tool using on-screen controls
M291 X1 Y1 P"Using the on-screen controls, adjust the position of the left tool until it is aligned with the reticle." R{var.macro_title} S2

; Once the user accepts, save that position, park the left tool, and move the right tool to that position. (don't select it)
set var.x_base_point = move.axes[0].machinePosition
set var.y_base_point = move.axes[1].machinePosition

M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
M291 P"The machine will now move the right tool into position." R{var.macro_title} S2

G0 X{move.axes[0].min} F{global.safe_speed}   ; park the X carriage
G0 U{var.x_base_point}                        ; Position the U carriage
M400                                          ; Wait for moves to finish

; Ask the user to align the new tool in the same manner.
M291 U1 Y1 P"Using the on-screen controls, adjust the position of the right tool until it is aligned with the reticle." R{var.macro_title} S2

; Once the user accepts, calculate the offsets, save and apply them, and park the tool.
set var.t1_x_offset = var.x_base_point - move.axes[3].machinePosition
set var.t1_y_offset = var.y_base_point - move.axes[1].machinePosition

M400

M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
M291 P"Please remove the CXC from the build area." R{var.macro_title} S2

M291 P"The machine will now park the right tool." R{var.macro_title} S2

G0 U{move.axes[3].max} F{global.safe_speed}   ; park the U carriage
M400

G10 P1 U{var.t1_x_offset} Y{var.t1_y_offset}
M500 P10

M98 P{directories.system^"/System Macros/Alert Sounds/success.g"}
M291 P"The new offsets have now been saved." R{var.macro_title} S2
