;
; Ordenando, maior e menor.asm
;
; Created: 22/04/2021 20:47:11
; Author : Amanda
;


; Replace with your application code
start:
	; copia dados para vetores
	rcall copia_v_z
	;chamando rotina para ordenar vetor
	ldi r26, 10
	ldi r25, high(v_z) ; r25 = parte alta do endereço do primeiro valor do vetor
	ldi r24, low(v_z) ; r24 = parte baixa do endereço do primeiro valor do vetor
	;rcall sort
	;chamando rotina para encontrar maior
	ldi r26, 10
	ldi r25, high(v_v)
	ldi r24, low(v_v)
	rcall maior
	ldi r24, 0x27
	sts v_maior, r24 ; guarda na memoria o resultado
	;chamando rotina para encontrar maior
	ldi r26, 10
	ldi r25, high(v_v)
	ldi r24, low(v_v)
	rcall menor
	sts v_menor, r24

_end:
	nop
    rjmp _end

; r25:r24 recebe o endereco do vetor
; r26 recebe o tamanho do vetor
; a rotina ordena o vetor
sort:
	mov yh, r25
	mov yl, r24
	dec R26
loop_sort:
	ld r15, Y+
	dec R26
	BRNE loop_sort
	ret

; r25:r24 recebe o endereco do vetor
; r26 recebe o tamanho do vetor
; retorna r25 igual a zero e r24 com o MAIOR valor do vetor
maior:
	mov yh, r25
	mov yl, r24
	ld r24, Y+
loop_maior:
	ld r25, Y+
	cp r24, r25
	brmi update_maior
	dec R26
	BRNE loop_maior
	ret
update_maior: ;
	mov r24, r25
	dec R26
	BRNE loop_maior
	ret

; r25:r24 recebe o endereco do vetor
; r26 recebe o tamanho do vetor
; retorna r25 igual a zero e r24 com o MENOR valor do vetor
menor:
	mov yh, r25
	mov yl, r24
	ld r24, Y+
loop_menor:
	ld r25, Y+
	cp r24, r25
	BRPL update_menor
	dec R26
	BRNE loop_menor
	ret
update_menor: 
	mov r24, r25
	dec R26
	BRNE loop_menor
	ret


;; simples codigo para copiar o vetor para a memoria IRAM
copia_v_z:
	ldi zh, high(__v)
	ldi zl, low(__v)
	ldi xh, high(v_v) ;; suas rotinas não devem usar os labels (so parametros)
	ldi xl, low(v_v)
	clc
	rol zl
	rol zh
	ldi r16, v_size ;; suas rotinas não devem usar v_size
loop1:
	lpm r17,z+
	st x+,r17
	dec r16
	brne loop1
	nop
	ldi zh, high(__v)
	ldi zl, low(__v)
	ldi xh, high(v_z)
	ldi xl, low(v_z)
	clc
	rol zl
	rol zh
	ldi r16, v_size
loop2:
	lpm r17,z+
	st x+,r17
	dec r16
	brne loop2
	nop
	ret

; este é um vetor de teste
; lembre-se que este valores podem mudar
; sinta-se livre para alterar e testar o seu programa
__v: 
.db 3,4,7,1,2,3,2,9,8,0,0,0
.equ v_size = 10

.dseg
v_v: ;vector 1
.byte 20
v_z: ;vector 2
.byte 20 
v_maior:
.byte 1
v_menor:
.byte 1
