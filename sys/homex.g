; homex.g
; called to home the X axis
var x_length = move.axes[0].max - move.axes[0].min

T-1 P0                                ; deselect the active tool
G91                                   ; relative positioning
G1 H2 Z10 F3000                       ; lift Z relative to current position
G1 H1 H2 X{-(var.x_length*1.1)} F6000 ; move quickly to X axis endstop and stop there (first pass)
G1 H2 X5 F3000                        ; go back a few mm
G1 H1 H2 X-10 F360                    ; move slowly to X axis endstop once more (second pass)
G90                                   ; absolute positioning
G1 H2 X{global.x_park_position} F3000 ; move to the x park position
G91                                   ; relative positioning
G1 H2 Z-10 F3000                      ; lower Z again
G90                                   ; absolute positioning