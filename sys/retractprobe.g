; ***********************************************************
; Euclid Probe Fixed Dock Retract Probe Macro M402
; RRF3.x Firmware
; ***********************************************************
;  __________________________________________________________________________
;  |                                                                        |
;  |   X7 Y582  X30 Y582     X100 Y582                                      |
;  | * Dock   * Dock Side  * Dock Preflight                                 |
;  |                                                                        |
;  | * Dock Exit Position                                                   | 
;  |   X7 Y542                                                              |
;  |                                                                        |
;  | * Dock staging position                                                |
;  |   X7 Y512                                                              |
;  |                                                                        |
;  |                                                                        |
;  |                                                                        |
;  |                                                                        |
;  |                                * Probe Ready Position                  |
;  |                                  X300 Y300                             |
;  |                                                                        |
;  |                                                                        |
;  |                                                                        |
;  |                                                                        |
;  |                                                                        |
;  |                                                                        |
;  |                                                                        |
;  |                                                                        |
;  |                                                                        |
;  |________________________________________________________________________| 
;
T-1 P0

if !exists(global.probe_deployed)
	global probe_deployed = true
else
	set global.probe_deployed = true

G91	                          ; absolute positioning
G0 H2 Z10 F3000              ; move Z 10mm for clearance above dock.
G90

if sensors.probes[0].value[0]!= 0
	set global.probe_deployed = false
    abort "retractprobe: Probe not currently picked up!"

G0 X{global.dock_position_x} Y{global.dock_position_y-70} F9000		; move to Dock Re-entry staging position 
M400																; wait for moves to finish
G0 X{global.dock_position_x} Y{global.dock_position_y-40}  F3000	; move to the entry position for the dock
M400																; wait for moves to finish
G0 X{global.dock_position_x} Y{global.dock_position_y}  F1200		; move into the dock position
M400																; wait for moves to finish
G4 P250																; pause 250 usecs 
G0 X{global.dock_position_x+30} Y{global.dock_position_y} F3000		; move to the side adjacent to the dock swiping the probe off
G0 X{global.dock_position_x+100} Y{global.dock_position_y} F9000	; move to the side adjacent to the dock swiping the probe off
M400																; wait for moves to finish

G91
G0 H2 Z-10 F3000              ; move Z back.
G90
M400                          ; wait for moves to finish

if sensors.probes[0].value[0]!= 1000
    abort "retractprobe: Probe not correctly dropped off in dock!"

set global.probe_deployed = false