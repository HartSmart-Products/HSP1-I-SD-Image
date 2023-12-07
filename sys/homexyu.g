; homexyu.g
; called to home X, Y and U
var x_length = move.axes[0].max - move.axes[0].min
var u_length = move.axes[3].max - move.axes[3].min
var y_length = move.axes[1].max - move.axes[1].min

var LY_driver = move.axes[1].drivers[0]
var RY_driver = move.axes[1].drivers[1]

G91											; relative positioning
T-1 P0										; deselect the active tool
M579 U1										; un-invert U axis
G1 H2 Z5 F3000								; lift Z relative to current position
G1 H1 H2 X{-(var.x_length*1.1)} Y{-(var.y_length*1.1)} U{(var.u_length*1.1)} F6000	; move quickly to X and Y axis endstops and stop there (first pass)
G1 H2 X5 Y5 U-5 F30000						; go back a few mm
G1 H1 H2 X-10 Y-10 U10 F360					; move slowly to X and Y axis endstops once more (second pass)
;M584 Y{var.LY_driver} V{var.RY_driver} P5	; separate Y axis into two axes
;M92 V{move.axes[1].stepsPerMm}				; set new axis steps per mm
;M564 H0									; allow movement without homing to square
;G92 V0
;G1 H2 V{global.y_axis_skew}				; square Y by moving V
;M584 Y{var.LY_driver, var.RY_driver} V P4	; rejoin Y axis and hide U from UI
G1 H2 Z-5 F3000								; lower Z again
;M564 H1									; enforce axis minimums and maximums and only allow movement after homing
G90											; absolute positioning
