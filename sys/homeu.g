; homeu.g
; called to home the U axis
var u_length = move.axes[3].max - move.axes[3].min

T-1 P0								; deselect the active tool
M579 U1								; un-invert U axis
G91									; relative positioning
G1 H2 Z10 F3000						; lift Z relative to current position
G1 H1 H2 U{var.u_length*1.1} F6000	; move quickly to X axis endstop and stop there (first pass)
G1 H2 U-5 F3000						; go back a few mm
G1 H1 H2 U10 F360					; move slowly to X axis endstop once more (second pass)
G91									; relative positioning
G1 H2 Z-10 F3000					; lower Z again
G90									; absolute positioning
