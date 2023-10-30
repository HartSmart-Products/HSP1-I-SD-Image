; tpost2.g
; called after tool 2 has been selected

M208 X{global.x_max_travel_duplicator} S0	; set axis maxima

M567 P2 E1:1 				; set tool mix ratio
M98 P{directories.system^"/System Macros/Tool Change/tpost.g"}
;M593 P"zvd" F40.0 S0.10		; configure input shaping for T0
