; homexyu.g
; called to home X, Y and U
;
var LY_driver = move.axes[1].drivers[0]
var RY_driver = move.axes[1].drivers[1]

G91											; relative positioning
G1 H2 Z5 F300								; lift Z relative to current position
G1 H1 X-655 Y-655 U655 F6000				; move quickly to X and Y axis endstops and stop there (first pass)
G1 H2 X5 Y5 U-5 F30000						; go back a few mm
G1 H1 X-10 Y-10 U10 F360					; move slowly to X and Y axis endstops once more (second pass)
M584 Y{var.LY_driver} V{var.RY_driver} P5	; separate Y axis into two axes
M92 V{move.axes[1].stepsPerMm}				; set new axis steps per mm
M564 H0										; allow movement without homing to square
G92 V0
G1 H2 V{global.y_axis_skew}					; square Y by moving V
M584 Y{var.LY_driver, var.RY_driver} V P4	; rejoin Y axis and hide U from UI
G1 X2 Z-5 F3000								; lower Z again
M564 H1										; enforce axis minimums and maximums and only allow movement after homing
G90											; absolute positioning