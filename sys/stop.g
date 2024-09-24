; stop.g
; called when M0 (Stop) is run (e.g. when a print from SD card is cancelled)
M98 P{directories.system^"/System Macros/Change Settings/reset_filament_monitor_sensitivity.g"}

; Deselect the active tool
T-1

; Lower the bed for accessiblity
G91
G0 Z15 F3000
G90

; Turn off all tools
M568 P0 A0
M568 P1 A0
M568 P2 A0

; Disable Mesh Compensation.
G29 S2

; Park
G0 Y600

