; tpost3.g
; called after tool 3 has been selected

M567 P2 E1:1 				; set tool mix ratio
M98 P{directories.system^"/System Macros/Tool Change/tpost.g"}
M579 U-1					; invert U axis for mirroring
