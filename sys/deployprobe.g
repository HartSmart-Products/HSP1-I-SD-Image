; ***********************************************************
; Euclid Probe Fixed Dock M401 Deploy Probe Macro
; RRF3.X Firmware
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
	global probe_deployed = false
else
	set global.probe_deployed = false

if !move.axes[0].homed || !move.axes[1].homed ||  !move.axes[3].homed   ; If the printer hasn't been homed, home it
    M98 P"0:/sys/homexyu.g" 

G91											; relative positioning
G0 H2 Z10 F3000								; move Z 10mm for clearance above dock.
G90											; absolute positioning

if sensors.probes[0].value[0]!=1000			; if sensor is value other than 1000, the probe is probably already picked up
	M291 R"Probe Already Deployed" P"The probe appears to already be deployed. Press Ok if the probe is deployed." S3
	;abort "deployprobe start value Probe already picked up.  Manually return probe to the dock"
else
	; Deploy probe moves
	G0 X{global.dock_position_x+100} Y{global.dock_position_y} F9000	; move to Preflight Position
	M400																; wait for moves to finish
	G0 X{global.dock_position_x+30} Y{global.dock_position_y} F3000		; move to Dock Side dock location
	M400																; wait for moves to finish
	G0 X{global.dock_position_x} Y{global.dock_position_y} F1200		; move over Dock 
	G4 P500																; pause 0.5 seconds
	M400																; wait for moves to finish
	G0 X{global.dock_position_x} Y{global.dock_position_y-30} F3000		; slide probe out of dock - slowly
	G0 X{global.dock_position_x} Y{global.dock_position_y-70} F9000		; move to re-entry position
	M400																; wait for moves to finish

	G90											; absolute positioning
	;G0 X300 Y300 F6000							; move to the center of the bed
	M400										; wait for moves to finish

	if sensors.probes[0].value[0]!=0
		abort "Deployprobe endvalue not 0 Probe not picked up!  Deploy cancelled."

set global.probe_deployed = true