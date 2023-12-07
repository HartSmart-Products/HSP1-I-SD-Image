; homey.g
; called to home the Y axis
var y_length = move.axes[1].max - move.axes[1].min

var LY_driver = move.axes[1].drivers[0]
var RY_driver = move.axes[1].drivers[1]

G91											; relative positioning
T-1 P0										; deselect the active tool
G1 H2 Z5 F3000								; lift Z relative to current position
G1 H1 H2 Y{-(var.y_length*1.1)} F6000		; move quickly to Y axis endstop and stop there (first pass)
G1 H2 Y5 F3000								; go back a few mm
G1 H1 H2 Y-10 F360							; move slowly to Y axis endstop once more (second pass)
;M584 Y{var.LY_driver} V{var.RY_driver} P5	; separate Y axis into two axes
;M92 V{move.axes[1].stepsPerMm}				; set new axis steps per mm
;M564 H0									; allow movement without homing to square
;G92 V0
;G1 H2 V{global.y_axis_skew}				; square Y by moving V
;M584 Y{var.LY_driver, var.RY_driver} V P4	; rejoin Y axis and hide U from UI
G1 H2 Z-5 F3000								; lower Z again
;M564 H1									; enforce axis minimums and maximums and only allow movement after homing
G90											; absolute positioning
