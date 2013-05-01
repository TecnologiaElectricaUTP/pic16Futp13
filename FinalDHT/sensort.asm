;Contador de 4 digitos 0000 a 9999 en displays con PIC877
; ******** DEFINICION DE REGISTROS UTILIZADOS

pcl 	equ	02h
status	equ	03
STATUS	equ	03
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
trise	equ	89h
txsta	equ	98h
spbrg	equ	99h
adresl	equ	9eh
adcon1	equ	9fh
;Definicion de bits utilizados
rp0	equ	5
rp1	equ	6
irp	equ	7
z	equ	2
c	equ	0
C	equ 0
txif	equ	4
go	equ	2
;Variables del usuario
loops	equ	30h
loops2	equ	31h
loops3	equ	36h
comp	equ 22h
Unidad 	equ 20h 			;Para almacenar unidades
Decena 	equ 21h 			;Para almacenar decenas


; ************  Configuracion para el simulador Proteus
list p=16f877

_CP_ALL                      	EQU     H'0FCF'
_CP_HALF                     	EQU     H'1FDF'
_CP_UPPER_256                	EQU     H'2FEF'
_CP_OFF                      	EQU     H'3FFF'
_DEBUG_ON                		EQU     H'37FF'
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
;:::::::::::::::::INICIO :::::::::::::::::
		org		0x00        ;begin in 0 address ram!
		goto		inicio	;main 
;:::::::::::::::::::::::::::::::::::::::::::
;-----------RETARDO MILISEGUNDOS-----------------
retarms		
            movwf		loops		;retardo de milisegundos cargado desde afuera
otro2		
            movlw		d'110'
		    movwf		loops2
otro	nop
		nop
		nop
		nop
		nop
		nop
		decfsz		loops2,1
		goto		otro
		decfsz		loops,1
		goto		otro2
		return

;#############TABLA ################################
tabla	addwf	pcl,1 		; leds a encender en orden -gfedcba
		retlw	b'11000000'	;0
		retlw	b'11111001'	;1
		retlw	b'10100100'	;2
		retlw	b'10110000'	;3
		retlw	b'10011001'	;4
		retlw	b'10010010'	;5
		retlw	b'10000011'	;6
		retlw	b'11111000'	;7	
		retlw	b'10000000'	;8	
		retlw	b'10010000'	;9
;########### DISPLAY ########################################
;Originally taken from duque's sample.
display	
								 ;rutina que carga cada dato en su respectivo display
		movf		Unidad,0	 ;activando el transistor correspondiente en cada caso
		call		tabla		 ;Display derecho es representado por digito0
		movwf		ptob
		bcf		    ptoc,1		;Activa el display derecho	
		movlw		d'5'		;Retardo de 5 ms 
		call		retarms
		bsf		    ptoc,1		;desactiva el display derecho
		movf		Decena,0	
		call		tabla
		movwf		ptob		;pone el dato de display izquierdo 
		bcf		    ptoc,0		;activa display izquierdo	
		movlw		d'5'		;Retardo de 5 ms 
		call		retarms		
		bsf		    ptoc,0		;desactiva display izquierdo 
		return		
;PUERTOS------------------
ports		bcf		status,6		
		bsf		status,5		
		movlw		b'1111111'
		movwf		trisa
		movlw		b'10000000'
		movwf		trisb
		movlw		b'11111100'
		movwf		trisc
		movlw		b'11110000'
		movwf		trisd
		movlw		b'11101110'
		movwf		trise		    ;puerto E entradas  
		movlw		b'00000001'	    ;selecciono Vref internos (+5 y GND) y 5 canales del puerto A analogos, puerto E todo digital
						            ; 0001 A A A A VREF+ A A A RA3 VSS 7/1 RA0 como canal analogo Ane como referencia externa Vref + = Vdd micro Vref- = Vss
		movwf		adcon1		    
		bcf			status,rp0	    ;pasar al banco 0
		movlw		b'10000001'	    ;selecciona canal RA0, reloj de conv. fosc/32
                            		;Adcon0 	b'10'   	Fosc/32 
                            		;			b'--000'	;Channel RA0 for usage !
                            		;			b'-----0 o 1' ;CAD is doing the homework or not 
                            		;			b'------	' ;Operative or not 
		movwf		adcon0	    	;Turn on the converter(CAD)
		return
;:::::::::Convertion :::::::::::
;Originally taken from duque's sample.
;La rutina de conversion solo encarga de la adquision de los datos,guardado de datos 
;en variables conocidas como BIN,luego retorna 
conver
	nop
	nop			    ;estas instrucciones nop sirven para
	nop			    ;darle al micro el tiempo de adquisicion
	nop			    ;requerido. En este caso es de 7 us aprox.
	nop
	nop
	nop
	nop
	bsf     adcon0,go	  ;inicia conversion
	nop
	nop
consu	
	btfsc	adcon0,go	;espera que termine de convertir el dato
	goto	consu
	movf	adresh,0	;guarda resultado en BIN !
	movwf 	comp
	movwf	Unidad
	
	return
;---------Converter Binary Code to  BCD-------
;Taken from www.utp.edu.co/~eduque/sistemasdigitales2
;Modified by students group :Gallego,Velez,Jimenez,Salazar.

;=============== CONVIERTE UN NUMERO BINARIO A BCD ===========
; La rutina sólo requiere que se coloque el valor
; a convertir en un registro, denominado aquí Unidad.
; Ella retorna las decenas y las centenas (dígitos
; decimales) en un par de registros adicionales.

Bin_BCD
		clrf 	Decena 		;Limpiar decenas	
		movlw 	d'10' 		;Cargar a W con decimal 
Repite 		
		subwf	 Unidad 	;Restarle al valor digital 10
		btfss 	status,0 	;Verificar estado del carry
		goto 	SUM1 			;Si cero, dejar de restar 10
		incf 	Decena 		;Si uno, incrementa decenas
		goto 	Repite 		;y repite la resta de 10
SUM1 	addwf 	Unidad		;Sumarle 10 al valor digital
		RETLW 0				;Regresa con 0
return

;*************** Main ASM *****************************
inicio		
		call            ports           ;configure the right ports and trisx's 
		clrf		ptob	   		;Clean port B and C for {RB0:RB7 == 0 ,RC0:RC7 ==0 }
		clrf		ptoc
		clrf		ptod		    ;clean port d 
		bsf ptod,3

a		call 		conver		    ;Call converter subrutine CAD
      	        nop
		call Bin_BCD	
		call		display		    ;refresh display 

	movlw d'32'
	subwf	comp,0
	btfss	status,c
	goto	Unidad_ES_MENOR_AL_T
	btfss	status,z
	nop
	goto	Unidad_ES_MAYOR_AL_T	
	goto	inicio

Unidad_ES_MENOR_AL_T
		bcf	ptod,0		;motor apagado
		bcf ptod,2
		bsf ptod,1		;led rojo encendido
		goto a
		
Unidad_ES_MAYOR_AL_T
		bsf ptod,0		;enciende motor
		bcf ptod,1		;
		bsf ptod,2		;enciende led verde
		goto 	a 
		goto		inicio			;puede ser a ciclo 1 
		end