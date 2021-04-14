;
; 02_Entradas_Saidas.asm
;
; Created: 13/04/2021 22:27:32
; Author : Amanda
;


; Replace with your application code
start:
	SBI DDRB, 5 // led da placa no pino 5 > saída
	SBI DDRD, 7 // led externo no pino 7 > saída
	SBI PORTD, 4 // botão na PD4
	SBI PORTB, 5 // PB5 <- 1

espera_botao: //acende o led da placa até o botao vir
	CBI PORTD, 7 // PD7 <- 0
	SBIS PIND, PD4 // Skip if Bit in I/O Register Cleared >>>> branch if botao ligado = 0
	JMP espera_botao

botao_pressionado: // PD4 <- 0
	CBI PORTB, 5 // PB5 <-0
	SBIC PIND, 4 // Skip if Bit in I/O Register is Set
	JMP botao_pressionado

loop_fim:
	SBI PORTD, 7 // PD7 <- 1
	RCALL delay_05
	CBI PORTD, 7 // PD7 <- 0
	RCALL delay_05
	RJMP loop_fim
delay_05:
	LDI R16, 8
loop1:
	LDI R24, low(3037)
	LDI R25, high(3037)
delay_loop:
	adiw R24, 1
	brne delay_loop
	dec R16
	brne loop1
	ret
