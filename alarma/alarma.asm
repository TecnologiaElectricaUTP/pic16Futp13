; Descripcion :Alarma Comercial  con pic16f877a
; Autores : Darwin Salazar - Hector Jimenez Saldarriaga 
; Feedback : hfjimenez@utp.edu.co,darsalazar@utp.edu.co	


;WARNING
; Tener en cuenta para retardos:
;1S==1000ms ==1000000µs 
;cada instruccion usa 1µs si es de control 2µ con cristal == 4Mhz 

;######################################################################
;				Generalidades del Micro 
;Resumen de FSR's y GPR 
;--------------------------------------------------------------------------------
;Memoria de programa : FLASH, 8 K de instrucciones de 14 bits c/u. 
; Memoria de datos       : 368 bytes RAM, 256 bytes EEPROM. 
; Pila (Stack)  : 8 niveles (14 bits). 
; Fuentes de interrupción : 13 
; Instrucciones  : 35 
; Encapsulado  : DIP de 40 pines. 
; Frecuencia oscilador : 20 MHz (máxima) 
; Temporizadores/Contadores: 1 de 8 bits (Timer 0); 1 de 16 bits (Timer 1); 1 de 8 bits (Timer 2) con pre y post escalador. Un perro guardián (WDT) 
; Líneas de E/S :  6 del puerto A, 8 del puerto B, 8 del puerto C, 8 del puerto D y 3 del puerto E, además de 8 entradas análogas. 
; Dos módulos de Captura, Comparación y PWM: 
;- Captura: 16 bits. Resolución máx. = 12.5 nseg. 
;- Comparación: 16 bits. Resolución máx. = 200 nseg. 
;- PWM: Resolución máx. = 10 bits. 
; Convertidor Análogo/Digital de 10 bits multicanal (8 canales de entrada). 
; Puerto serial síncrono (SSP) con bus SPI (modo maestro) y bus I²C (maestro/esclavo). 
; USART (Universal Synchronous Asynchronous Receiver Transmitter) con dirección de detección de 9 bits. 
; Corriente máxima absorbida/suministrada (sink/source) por línea (pin): 25 mA 
; Oscilador : Soporta 4 configuraciones diferentes: XT, RC,  HS, LP. 
; Tecnología de Fabricación: CMOS 
; Voltaje de alimentación: 3.0 a 5.5 V DC
 
;################BANCO 0##############
 
;- TMR0: Registro del temporizador/contador de 8 bits. 
;- PCL: Byte menos significativo del contador de programa (PC). 
;- STATUS: Contiene banderas (bits) que indican el estado del procesador 
;   después de una operación aritmética/lógica. 
;- FSR: Registro de direccionamiento indirecto. 
;- PORTA, PORTB, PORTC, PORTD, PORTE: Registro de puertos de E/S de  datos. Conectan con los pines físicos del micro. 
;- PCLATH: Byte alto (más significativo) del contador de programa (PC). 
;- INTCON: Registro de control de las interrupciones. 
;- ADRESH: Parte alta del resultado de la conversión A/D. 
;- ADCON0: Controla la operación del módulo de conversión A/D 
;##################BANCO 1###############
;- OPTION: Registro de control de frecuencia del TMR0. 
;- TRISA, TRISB, TRISC, TRISD. TRISE: Registros de configuración de la operación de los pines de los puertos. 
;- ADRESL: Parte baja del resultado de la conversión A/D. 
;- ADCON1: Controla la configuración de los pines de entrada análoga. 
;##########################BANCO 2#######################
;- TMR0: Registro del temporizador/contador de 8 bits. 
;- PCL: Byte menos significativo del contador de programa (PC). 
;- FSR: Registro de direccionamiento indirecto. 
;- EEDATA: Registro de datos de la memoria EEPROM. 
;- EEADR: Registro de dirección de la memoria EEPROM. 
;- PCLATH: Byte alto (más significativo) del contador de programa (PC). 
;- INTCON: Registro de control de las interrupciones. 
 
;#########BANCO 3##################
;- OPTION: Registro de control de frecuencia del TMR0. 
;- EECON1: Control de lectura/escritura de la memoria EEPROM de datos. 
;- EECON2: No es un registro físico.
;----------------------------------------------------------------------------------------



;######################################################################
;		Generalidades del Problema de la Alarma  Comercial 
;######################################################################
;							I/O
;SENSORES I/O :{Rb0 = B0 = Llave, Rb1 = B1 = SMVTO ,Rb2= P0 = Spuerta, Rb3 = S0 =SIRENA}
;{Rc0,Rc1,Rc2 = Contraseña para activacion de alarma,RC3=L0= LED ROJO,RC4=L1=LED VERDE}
;Pseudo Codigo
;1.si B0==0 								;SISTEMA OFF 
;2.por lo cual RC3==1 Y vuelva a preguntar 	;Enciende Led de color rojo
;3.de lo contrario  						;SISTEMA ON 
;4.Llamar a retardo							;Retardo de 10 segundos 
;5.poner RC4==1								;Led Verde Encendido
;6.si B1==0 								;Sensor de Moviento detecta 
;7.entonces S0==1 							;Sirena empieza a sonar 
;8.llamar a retardo 20segundo				;Suena durante de 20s 
;9.si P0==1 								;sensor de puerta se activo 
;10.llamar a retardo 						;retardo de 10 segundos 
;11. de lo contrario S0==1 					;Alarma suena indefinidamente
;fin 
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
trise	equ	89h
txsta	equ	98h
spbrg	equ	99h
adresl	equ	9eh
adcon1	equ	9fh

;Definicion de bits utilizados
rp0		equ	5
rp1		equ	6
irp		equ	7
z		equ	2
c		equ	0
txif	equ	4

;Variables para retardo
cblock  0x20
		PDel0
		PDel1
		PDel2
endc
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

;Copy Protection Off -WatchdoG Timer Off -Oscilardor Xt 4Mhz -Power on reset on 

;################MAIN###############################################
 
	org	0x00		          ;Empieza ejecucion en direccion 000h
	goto	inicio  		  ;retardo de 10 segundos
demora  movlw     d'43'       ; 1 set numero de repeticion  (C)
        movwf     PDel0       ; 1 
PLoop0  movlw     d'226'      ; 1 set numero de repeticion  (B)
        movwf     PDel1       ; 1 
PLoop1  movlw     d'205'      ; 1 set numero de repeticion  (A)
        movwf     PDel2       ; 1 
PLoop2  nop              	  ; 1 
        nop              	  ; 1 ciclo delay
        decfsz    PDel2, 1    ; 1 + (1) es el tiempo 0  ? (A)
        goto      PLoop2      ; 2 no, loop
        decfsz    PDel1,  1 
        goto      PLoop1    
        decfsz    PDel0,  1 
        goto      PLoop0     
        nop              	 
        return             
;#############PUERTOS####################
;SENSORES I/O :{Rb0 = B0 = Llave, Rb1 = B1 = SMVTO ,Rb2= P0 = Spuerta, Rb3 = S0 =SIRENA}
;{Rc0,Rc1,Rc2 = Contraseña para activacion de alarma,RC3=L0= LED ROJO,RC4=L1=LED VERDE}
puertos
	bcf	status,rp1	;pasar al banco 1
	bsf	status,rp0	;pasar al banco 1 de la RAM
	movlw	b'11111111'		
	movwf	trisa		;puerto A entradas
	movlw	b'11110111'
	movwf	trisb		;puerto B salidas
	movlw	b'11100111'
	movwf	trisc		;puerto C entradas  
	movlw	b'11100111'  
	movwf	trisd		;puerto D entradas 
	movlw	b'11101111'
	movwf	trise		;puerto E entradas  
	movlw	b'11110111'	; Puerto A y E solo digital
	movwf	adcon1
	clrw 				;Limpio W.
	bcf	status,rp0		;pasar al banco 0
	return 
;  ************  PROGRAMA PRINCIPAL  ***************
;programa opcional simple
;abierto clrf	ptob
;	btfss   ptob,1          ;pregunta si hay un uno en la llave
;	goto    abierto
;    call    r1
;sensorb btfss   ptob,2          ;pregunta si hay un uno en el sensor magnetico
;	goto    sensora
;	call    r1
;    goto    alarma
;sensora btfss   ptob,3           ;sensor de mivimiento pregunta si esta en uno
;    goto    sensorb
;alarma 	bsf	ptob,0
;	call	r1
; 	call	r1
;	bcf	ptob,0
;	goto	abierto
;	end

;########## INICIO ##############
inicio	
		call puertos 		;configuro pines
		nop					;nop
		clrf	ptob		;Limpio pines de puerto b 
		clrf 	ptoc		; Limpio pines de puerto c
disable btfsc	ptob,0		;pregunto si B0==0 si es cero salta dos posiciones adelante
		goto 	activado	;delo contrario va a activado
		bsf ptoc,3			;enciende led rojo	
		goto disable 		;se queda preguntando por si esta activado  o no !
		;goto	inicio		;Vuelve a empezar el ciclo 

;Modo de Vigilancia		
activado		 
		nop 
		bcf ptoc,3		;apaga led rojo 
		call demora 	;llama retardo de 10 segundos
		bsf ptoc,4		;enciende led  indicadorde color verde
puerta	btfss ptob,2	;pregunta si hay uno en sensor magnetico
		goto  sensormov	;si no hay uno en sensor magnetico de puerta,pregunte por sensor de movimiento 
						;Enciende alarma 
		call demora 	;si hay uno en sensor de puerta 
		bsf  ptob,3	
		call demora 
		call demora
		bcf  ptob,3		;apaga  alarma 
		goto puerta 	;vuelve y checka que no halla nadie,si no suena
		
		
sensormov	btfss ptob,1 	;hay movimiento ? si 
			goto puerta
			bsf  ptob,3		
			call demora
			call demora
			bcf ptob,3
			goto sensormov 
		goto inicio 
		bsf ptob,3
	end
