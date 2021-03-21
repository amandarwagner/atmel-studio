;
; PiscaLed.asm
;
; Created: 21/03/2021 13:57:17
; Author : Amanda
;


; Replace with your application code
start:
    inc r16, 0xFF
	out DDRB, R16;
loop:
	sbi PORTB, 5
	rcall 
