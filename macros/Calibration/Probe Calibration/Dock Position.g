; Macro to aid with setting the dock position on the Euclid probe
var macro_title = "Probe Dock Position Calibration"

M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
M291 P"This Macro will assist with calibrating the probe dock position. It is recommended to run this macro on a mobile device or with a partner." R{var.macro_title} S3
M291 P"The X, Y, and U axes will now home and the left tool will be moved near the dock. Please confirm the bed is clear and no collisions will result." R{var.macro_title} S3

M98 P{directories.system^"/homexyu.g"}

G90
G0 Y610 F{global.rapid_speed/2}			; Move the gantry near the dock
M400									; Wait for moves to finish

M291 X1 Y1 P"Position the tool into the dock pickup position so the probe is attached to the toolhead." R{var.macro_title} S2

set global.dock_position_x = move.axes[0].machinePosition
set global.dock_position_y = move.axes[1].machinePosition

M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
M291 P"The machine will now deploy the probe using the specified position." R{var.macro_title} S2

G91
G0 X50 F{50*60}							; Slowly move the tool off the probe
G90
M401									; Deploy the probe
M400									; Wait for moves to finish

M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
M291 P"The machine will now stow the probe." R{var.macro_title} S2

M402									; Retract the probe
M400									; Wait for moves to finish

echo >{directories.system^"/Printer Parameters/Probe/dock_position.g"} {"set global.dock_position_x = "^global.dock_position_x}
echo >>{directories.system^"/Printer Parameters/Probe/dock_position.g"} {"set global.dock_position_y = "^global.dock_position_y}
M98 P{directories.system^"/Printer Parameters/Probe/dock_position.g"}

M98 P{directories.system^"/System Macros/Alert Sounds/success.g"}
M291 P"The new dock position has now been saved." R{var.macro_title} S2
