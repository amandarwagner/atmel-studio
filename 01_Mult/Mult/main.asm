;
; Mult.asm
;
; Created: 28/03/2021 21:11:06
; Author : Amanda
;

start:
	LDI r16, 195 ; registrador X
	LDI r17, 201 ; registrador Y
	LDI r18, 0 ; registrador Z low
	ldi r19, 0 ; registrador Z high
	LDI r20, 8 ; registrador count

checar_bit_y:
	LDI r22, 1 ; registrador 0000 0001
	AND r22, r17 ; comparar com último bit do r17
	BREQ shift_z ; se o bit menos significativo do y for 0, só shiftar o Z

soma:
	ADC r19, r16 ; soma o X no Z high

shift_z:
	ROR r19 ; rotar o Z high
	ROR r18 ; rotar o Z low 
	ROR r17 ; pegar o último bit do r17
	SUBI r20,1
	TST r20
	BRNE checar_bit_y ; se o contador não for 0, olhar o prox bit do y

fim:
	RJMP fim ; loop quando acabar