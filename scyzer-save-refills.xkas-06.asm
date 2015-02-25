lorom

; hijack Scyzer’s save routine at a convenient point
org $81EF40
	JSR refill_save

; 34 ($22) bytes that can be located anywhere in bank 81 free space
; (also avoiding Scyzer’s patch at EF20-F0A4)
org $81FFD0
refill_save:
	; place a semicolon at the beginning of any of these lines to disable them
	LDA $09C4 : STA $09C2 ; energy
	LDA $09D6 : STA $09D4 ; reserve tanks
	LDA $09C8 : STA $09C6 ; missiles
	LDA $09CC : STA $09CA ; super missiles
	LDA $09D0 : STA $09CE ; power bombs

	LDA $079F             ; overwritten by hijack
	RTS
