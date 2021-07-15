;
; 7seg.asm
;
; Created: 22/06/2021 19:43:55
; Author : Amanda
;


; Replace with your application code

.equ zero = 0b01111110	; aparecer zero no display
.equ um = 0b01001000 ; aparecer um no display
.equ dois = 0b00111101	; aparecer dois no display
.equ tres = 0b01101101	; aparecer tres no display
.equ quatro = 0b01001011 ; aparecer quatro no display
.equ cinco = 0b01100111 ; aparecer cinco no display
.equ seis = 0b01110111	; aparecer seis no display
.equ sete = 0b01001100	; aparecer sete no display
.equ oito = 0b01111111	; aparecer oito no display
.equ nove = 0b01101111	; aparecer nove no display

start:
	LDI R16, 0b11111111 ; setar saídas do display
	OUT DDRD, R16 ; saida para do display
	SBI DDRB, 5 ; led da placa -> saida
	
	LDI R16, zero ; carrega o zero para passar para o display
	OUT PORTD, R16 ; coloca zero no display
	
	SBI PORTB, 5 ; acende led da placa
	SBI PORTC, 0 ; ativar pull up do botao
	LDI R17, 10 ; define r17 como contador = 10

	LDI ZL, low(nums << 1)	; coloca o endereço inicial na parte baixa de Z
	LDI ZH, high(nums << 1) ; coloca o endereço inicial na parte alta de Z

display:
	LPM R16, Z+	; pega o end de Z e faz Z=Z+1
	OUT PORTD, R16 ; coloca o valor para o display

aperta_botao:
	SBIS PINC, 0
	JMP aperta_botao

led_placa:
	CBI PORTB, 5 ; apaga led da placa
	JMP solta_botao

solta_botao:
	SBIS PINC, 0
	JMP loop
	JMP solta_botao

loop:
	SBI PORTB, 5 ; acende led da placa
	DEC R17 ; contador--
	TST R17
	BRNE display ; verifica se é neg
	LDI ZL, low(nums << 1)
	LDI ZH, high(nums << 1)
	LDI R17, 10
	JMP display

nums:  .DB zero, um, dois, tres, quatro, cinco, seis, sete, oito, nove