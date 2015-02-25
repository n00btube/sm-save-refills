lorom

; hijack the save routine ($818000) at a convenient point
org $818013
	JSR refill_save

; 36 ($24) bytes that can be located anywhere in bank 81 free space
org $81FFD0
refill_save:
	PHA
	; place a semicolon at the beginning of any of these lines to disable them
	LDA $09C4 : STA $09C2 ; energy
	LDA $09D6 : STA $09D4 ; reserve tanks
	LDA $09C8 : STA $09C6 ; missiles
	LDA $09CC : STA $09CA ; super missiles
	LDA $09D0 : STA $09CE ; power bombs
	PLA

	LDY #$005E            ; overwritten by hijack
	RTS
