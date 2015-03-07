; Copyright 2015 Adam <https://github.com/n00btube>
; MIT license.

; Makes save points refill Samus' energy and supplies, like the ship.
;
; Compared to v1, it's smoothly animated, and hijacks differently...
; so there are no longer separate versions for the vanilla ROM and for
; Scyzer's load/save patch.

lorom

; hijack point: reconfigure the save-station PLM instructions. do not edit.
; the normal instructions go something like:
; [8CF1=prompt][B008][B00E=freeze/pose Samus][8C07,2E=saving sound]...
; we overwrite those first 3 words and chain into the hijacked instructions,
; making it act like
; [B00E][refill_run, repeated until full][8CF1][B008][8C07,2E]...
org $84AFEE
	DW refill_start    ; hijack the "save?" message & posing
	DW refill_run, $B008
	; the hijack will chain the PLMs we overwrote.
	; remaining PLM instructions are used as-is.

; this can be moved anywhere in bank $84’s free space, and MUST be bank $84.
; I'm sorry it's so huge, there's a lot to do.
org $84FF00
refill_start:
	TYA
	STA $1D27,X        ; set refill_run as next PLM instruction
	JSR $B00E          ; freeze and pose Samus (saves X/Y itself)
	STZ $05F9          ; steal "save?" msgbox response RAM for "done?"

refill_run:
	PHX : PHY          ; preserve regs

	; comment the LDX/JSR line (add a semicolon to the beginning of the line)
	; of any items you DO NOT want to refill.
	; for each line you comment, reduce the LDY value by 1: otherwise, the
	; refill will be infinite.  anything that is full decrements Y.
	LDY #$0005                ; set up "nothing fully refilled" value

	LDA #$0005 : STA $12      ; energy increment value per frame
	LDX #$09C2 : JSR inc_item ; energy tanks
	LDX #$09D4 : JSR inc_item ; reserve tanks

	LDA #$0002 : STA $12      ; other supplies increment value per frame
	LDX #$09C6 : JSR inc_item ; missiles
	LDX #$09CA : JSR inc_item ; super missiles
	LDX #$09CE : JSR inc_item ; power bombs

	TYA                ; hang onto fill-state result
	PLY : PLX          ; restore regs
	ASL                ; set Z flag if A is $0000 (saves 2 bytes vs. CMP)
	BNE refill_more    ; not all full: run this refill instruction next frame
	LDA $05F9          ; were we done last frame?
	BNE hijack_done    ; yes: jump to hijacked code
	INC                ; no: tell us we were, next frame
	STA $05F9          ; (so the HUD has a chance to draw at 100%)

refill_more:
	LDA #$0001         ; run it/us next frame
	STA $7EDE1C,X      ; write frame delay
	PLA                ; end current frame's instructions for this PLM
	RTS                ; run next PLM

hijack_done:
	JMP $8CF1          ; all items full: run hijacked save prompt


inc_item:
	LDA $0000,X        ; current value
	CMP $0002,X        ; max value
	BNE needs_inc      ; full?
	DEY : RTS          ; yes: mark full and return.
needs_inc:
	CLC : ADC $12      ; not full: add current increment value
	CMP $0002,X        ; is it full now?
	BCC inc_item_write ; less than full: only save back to current
	LDA $0002,X        ; equal or overfull: set to full
	DEY                ; mark full
inc_item_write:
	STA $0000,X        ; write new (calculated or max) value to current
	RTS                ; return
