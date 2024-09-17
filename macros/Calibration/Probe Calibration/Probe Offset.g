; Macro to aid with setting the probe and T1 Z offsets
var macro_title = "Probe Offset Calibration"
var x_point = 330
var y_point = 80
var t1_z_offset = 0

M291 P"This Macro will assist with calibrating the probe Z offsets. The machine will now home and move the tools for calibration. Please confirm the bed is clear and no collisions will result." R{var.macro_title} S3

T-1
G28										; Home the machine
G31 Z0									; Temporarily clear the probe offset for calibration

G29 S2									; Ensure mesh compensation is off
M290 R0 S0								; Clear babystepping
G90
G0 Z10 F{7.5*60}
G0 X{var.x_point} Y{var.y_point} F{global.rapid_speed/2}	; Move the left tool to position
M400									; Wait for moves to finish

M564 S0									; Allow movement beyond limits

M291 Z1 P"Using a piece of paper or ~.004 shim, adjust the position of the tool until there is a slight drag." R{var.macro_title} S2

G92 Z0									; Set the current Z position to 0
G0 Z10 F{7.5*60}						; Move up
M400									; Wait for moves to finish

M291 P"The machine will now move the right tool into position." R{var.macro_title} S2

G0 X{move.axes[0].min} F{global.rapid_speed/2}	; park the X carriage
G0 U{var.x_point}						; Position the U carriage
M400									; Wait for moves to finish

M291 Z1 P"Using a piece of paper or ~.004 shim, adjust the position of the tool until there is a slight drag." R{var.macro_title} S2

set var.t1_z_offset = -move.axes[2].userPosition
M400
G0 Z10 F{7.5*60}						; Move up
M400									; Wait for moves to finish

M291 P"The machine will now probe the set point." R{var.macro_title} S2

M401									; Deploy the probe
G0 X{var.x_point-sensors.probes[0].offsets[0]} Y{var.y_point-sensors.probes[0].offsets[1]} F{global.rapid_speed/2}
G30 S-3									; Probe and set trigger height
M400
M564 S1									; Disallow movement beyond limits
G0 Z10 F{7.5*60}						; Move up
M402									; Stow probe
M400

echo >{directories.system^"/Printer Parameters/Probe/probe_offset.g"} {"set global.probe_z_offset = "^sensors.probes[0].triggerHeight}
echo >{directories.system^"/Printer Parameters/Tool/t1_offsets.g"} {"set global.t1_x_offset = "^tools[1].offsets[3]}
echo >>{directories.system^"/Printer Parameters/Tool/t1_offsets.g"} {"set global.t1_y_offset = "^tools[1].offsets[1]}
echo >>{directories.system^"/Printer Parameters/Tool/t1_offsets.g"} {"set global.t1_z_offset = "^var.t1_z_offset}
M98 P{directories.system^"/Printer Parameters/Tool/t1_offsets.g"}
G10 P1 Z{global.t1_z_offset}

M291 P"The new offsets have now been saved." R{var.macro_title} S2
