; Macro to automatically PID tune the bed heater
var macro_title = "Bed PID Tuning"

if heat.heaters[0].current > 35
	M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
	M291 P"This macro must be run while the bed is at ambient temperature. Please turn it off and wait until it is below 35 degrees." R{var.macro_title} S2
	abort

M98 P{directories.system^"/System Macros/Alert Sounds/attention.g"}
M291 P"This Macro will run PID tuning on the bed. This process may take the better part of an hour." R{var.macro_title} S3

M291 P"Starting Bed PID tune" R{var.macro_title} T5
M307 H0 D60
M303 H0 P1 S100 Y2 Q1

G4 S2											; wait for the heater to change state
while heat.heaters[0].state = "tuning"			; wait for the PID tune to be completed
     G4 S2

M98 P{directories.system^"/System Macros/Alert Sounds/success.g"}
M291 P"Finished PID tuning, saving results..." R{var.macro_title} T5
M500 P10
