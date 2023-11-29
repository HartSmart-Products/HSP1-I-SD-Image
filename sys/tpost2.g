; tpost2.g
; called after tool 2 has been selected

M567 P2 E1:1 				; set tool mix ratio
M98 P{directories.system^"/System Macros/Tool Change/tpost.g"}
