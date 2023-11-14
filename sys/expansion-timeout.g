; B: CAN address of the board that has stopped communicating
; D: 0
; P: 0
; S: The full text string describing the fault

if state.status == "processing"
	M25

echo {"Expansion board "^param.B^" has disconnected."}
