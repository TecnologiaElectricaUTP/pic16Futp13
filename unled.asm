; Encender un LED con el PIC16F877

; ******** DEFINICION DE REGISTROS UTILIZADOS

status	equ	03
ptoa	equ	05
ptob	equ	06
ptoc	equ	07
ptod	equ	08
ptoe	equ	09
pclath	equ	0ah
intcon	equ	0bh
pir1	equ	0ch
rcsta	equ	18h
txreg	equ	19h
rcreg	equ	1ah
adresh	equ	1eh
adcon0	equ	1fh
trisa	equ	85h
trisb	equ	86h
trisc	equ	87h
trisd	equ	88h
txsta	equ	98h
trise	equ	89h
spbrg	equ	99h
adresl	equ	9eh
adcon1	equ	9fh

;Definicion de bits utilizados

rp0	equ	5
rp1	equ	6
irp	equ	7
z	equ	2
c	equ	0
txif equ 4
go	equ	2

;Variables del usuario

loops	equ	20h
loops2	equ	21h
buffer	equ	22h

; ************  Configuracion para el simulador Proteus

list p=16f877

_CP_ALL                      	EQU     H'0FCF'
_CP_HALF                     	EQU     H'1FDF'
_CP_UPPER_256                	EQU     H'2FEF'
_CP_OFF                      	EQU     H'3FFF'
_DEBUG_ON                	EQU     H'37FF'
_DEBUG_OFF                   	EQU     H'3FFF'
_WRT_ENABLE_ON               	EQU     H'3FFF'
_WRT_ENABLE_OFF              	EQU     H'3DFF'
_CPD_ON                      	EQU     H'3EFF'
_CPD_OFF                     	EQU     H'3FFF'
_LVP_ON                      	EQU     H'3FFF' 
_LVP_OFF                     	EQU     H'3F7F'	
_BODEN_ON                    	EQU     H'3FFF'
_BODEN_OFF                   	EQU     H'3FBF'
_PWRTE_OFF                   	EQU     H'3FFF'
_PWRTE_ON                    	EQU     H'3FF7'
_WDT_ON                      	EQU     H'3FFF'
_WDT_OFF                     	EQU     H'3FFB'
_LP_OSC                      	EQU     H'3FFC'
_XT_OSC                      	EQU     H'3FFD'
_HS_OSC                      	EQU     H'3FFE'
_RC_OSC                      	EQU     H'3FFF'

__CONFIG _CP_OFF & _WDT_OFF & _XT_OSC & _PWRTE_ON 



; ***** EMPIEZA EL PROGRAMA

	org	00		;Empieza ejecucion en direccion 000h
	goto	inicio

retarms movlw	d'255'     	;subrutina de retardo en milisegundos
	movwf	loops
top2    movlw   d'110' 	 	;el numero de milisegundos está 
        movwf   loops2  	;cargado en el registro loops
top    	nop
        nop
        nop
        nop
        nop
        nop
        decfsz  loops2,1  	;pregunta si termino 1 ms
        goto    top
        decfsz  loops,1  	;pregunta si termina el retardo
        goto    top2
        return


;  ************  PROGRAMA PRINCIPAL  ***************

inicio	bcf	status,rp1	;pasar al banco 1
	bsf	status,rp0	;pasar al banco 1 de la RAM
	movlw	b'11111111'		
	movwf	trisa		;puerto A entradas
	movlw	b'00000000'
	movwf	trisb		;puerto B salidas
	movlw	b'11111111'
	movwf	trisc		;puerto C entradas  
	movlw	b'11111111'
	movwf	trisd		;puerto D entradas 
	movlw	b'11101111'
	movwf	trise		;puerto E entradas  
	movlw	b'11110111'	; Puerto A y E solo digital
	movwf	adcon1
	bcf	status,rp0	;pasar al banco 0

	clrf	ptob		;Inicia LEDs apagados
	clrf 	ptoc
	bsf	ptob,0		;Encender LED
	bsf	ptoc,0
	call	retarms		;este retardo equivale a 255 milisegundos

	bcf	ptob,0		;ApagarLED
	bcf	ptoc,0	
	
	call	retarms		;este retardo equivale a 255 milisegundos
					
	
	goto	inicio		;Vuelve a empezar el ciclo 
			
	end
