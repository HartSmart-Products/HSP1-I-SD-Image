; Macro to automatically PID tune both tools.
var macro_title = "PID Tuning"

M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
M291 P"This Macro will run PID tuning on both tools. First it will home the machine and move the active tool above the printbed. Please confirm the bed is clear and no collisions will result." R{var.macro_title} S3

if !move.axes[0].homed || !move.axes[1].homed ||  !move.axes[3].homed ; If the printer hasn't been homed, home it
    M98 P{directories.system^"/homeall.g"}
else
	G90
	G0 U{move.axes[3].max} F{global.safe_speed}                          ; get the right tool out of the way

G90
G0 Z15 F300
G0 Y100 F{global.safe_speed}                                          ; Move the gantry to an accessible location
G0 X50                                                                ; Move Left tool over bed
G0 Z3 F300                                                            ; Move Left tool close to bed

M291 P"Starting Left tool PID tune" R{var.macro_title} T5
M303 T0 S230 Q1

G4 S2                                                                 ; wait for the heater to change state
while heat.heaters[1].state = "tuning"                                ; wait for the PID tune to be completed
     G4 S2

G0 Z15 F300
G0 X{move.axes[0].min} F{global.safe_speed}                           ; Move the gantry to an accessible location
G0 U600                                                               ; Move Left tool over bed
G0 Z3 F300                                                            ; Move Left tool close to bed

M291 P"Starting Right tool PID tune" R{var.macro_title} T5
M303 T1 S230 Q1

G4 S2                                                                 ; wait for the heater to change state
while heat.heaters[2].state = "tuning"                                ; wait for the PID tune to be completed
     G4 S2

G0 Z15 F300
T-1

M98 P{directories.system^"/System Macros/Alert Sounds/success.g"}
M291 P"Finished PID tuning, saving results..." R{var.macro_title} T5
M500 P10:31
