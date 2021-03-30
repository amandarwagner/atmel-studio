;
; Mult.asm
;
; Created: 28/03/2021 21:11:06
; Author : Amanda
;

start:
	LDI r16, 255 ; registrador X
	LDI r17, 7 ; registrador Y
	LDI r18, 0 ; registrador Z low
	ldi r19, 0 ; registrador Z high
	LDI r20, 8 ; registrador count
	LDI r21, 128 ; registrador 1000 0000

checar_bit_y:
	LDI r22, 1 ; registrador 0000 0001
	AND r22, r17
	BREQ shift_z ; se o bit menos significativo do y for 0, só shiftar o Z
	JMP soma ; se o bit menos significativo do y for 1, somar x no Z e depois shiftar

soma:
	ADC r19, r16 ; soma o X no Z high >> checar o carry da soma
	JMP shift_z ; shifta o Z

shift_z:
	ROR r19 ; rotar o Z high
	BRCS carry_ror_1; se o carry for 1, add no r18 1000 0000. se o carry for 0, shiftar o Z low
	ROR r18 ; rotar o Z low
	ROR r17;
	SUBI r20,1
	TST r20
	BRNE checar_bit_y

carry_ror_1:
	ROR r18 ; rotacionar o r18
	ADC r18, r21 ; add 1000 0000 no r18
	ROR r17;
	SUBI r20,1
	TST r20
	BRNE checar_bit_y

fim:
	RJMP fim ; loop quando acabar