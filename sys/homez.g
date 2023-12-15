; homez.g
; called to home the Z axis

G29 S2								; disable heightmap transform
M98 P{directories.system^"/System Macros/Change Settings/apply_babysteps.g"}

M401								; deploy probe
if global.probe_deployed == false	; check if the deploy macro completed successfully
	abort "Probe deploy error"
G0 X{325.0-sensors.probes[0].offsets[0]} Y{300.0-sensors.probes[0].offsets[1]} F{global.rapid_speed}	; move to probe position
G30									; probe the bed and set Z height
M402								; return probe to dock
