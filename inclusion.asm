;Template para Pic16f877
;ToDo :
;Crear Rutinas de tiempo
;Para crear retardos puedes usar T0 o sabiendo:

;   1S==1000ms ==1000000µs 
;cada instruccion usa 1µs si es de control 2µs

;Crear Conversion A/D
;Crear Manejadores de memoria de datos indirecto y directo
;Jugar con registros para XOR en memoria 
;Comprar un 18 con memoria flash para alcanzar a jaime A.
;Crear nuevas rutinas para espacio de 96 bytes 
 
 
 
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
 
;Pic 16f877 cuenta con 5 puertos de la {A-E}
 
pa equ 05h
pb equ 06h
pc equ 07h 
pd equ 08h
pe equ 09h 
 
;Definicion de direcionamiento la mayoria de los puertos son bidireccionales 
;e y d se utilizan para conversores a/d
 
ta equ 85h
tb equ 86h
tc equ 87h 
td equ 88h 
te equ 89h
 
 
;Definicion de  bits del registro status 
status equ  03h 
 
c     equ  0
dc    equ  1 
z     equ  2
pd    equ  3 
T0    equ  4 
rp0   equ  5 
rp1   equ  6
irp   equ  7
 
;Definicion de Registros temporales
 
;20h/7fh 96 bytes de memoria para proposito general...alrededor de 12 banco 0
;de A0h / 0EFh  80 bytes de proposito general banco 1
;de 120h/16fh   80 bytes de proposito general banco 2
 
temp equ 20h 
 
;ToDO :
;addicionar los tiempos de un segundo,a tres segundos 
;addicionar la conversion de AD
;Averiguar sobre la comunicacion.
 
; ************  Proteus Isis Configuration File
 
list p=16f877 ;it specify the class of pic.
;it is posible replace the inc files doing the proper asignation.see above.
;this values are used by the mpasm,asemp compilers
;when you're   enabling the enviroment values you can 
;use each one instruction inside the Pic,as you now you could 
;modify these options by next to parameters :
 
 
 
 
;_OPTION_CLASS_ONOROFF 
 
 
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
;xt oscilator,power on reset on,watchdog timer off,copy protection off
 
;#####Main############
 
org 0x000
goto start;Template para Pic16f877
;ToDo :
;Crear Rutinas de tiempo
;Crear Conversion A/D
;Crear Manejadores de memoria de datos indirecto y directo
;Jugar con registros para XOR en memoria 
;Comprar un 18 con memoria flash para alcanzar a jaime A.
;Crear nuevas rutinas para espacio de 96 bytes 
 
 
 
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
 
;Pic 16f877 cuenta con 5 puertos de la {A-E}
 
pa equ 05h
pb equ 06h
pc equ 07h 
pd equ 08h
pe equ 09h 
 
;Definicion de direcionamiento la mayoria de los puertos son bidireccionales 
;e y d se utilizan para conversores a/d
 
ta equ 85h
tb equ 86h
tc equ 87h 
td equ 88h 
te equ 89h
 
 
;Definicion de  bits del registro status 
status equ  03h 
 
c     equ  0
dc    equ  1 
z     equ  2
pd    equ  3 
T0    equ  4 
rp0   equ  5 
rp1   equ  6
irp   equ  7
 
;Definicion de Registros temporales
 
;20h/7fh 96 bytes de memoria para proposito general...alrededor de 12 banco 0
;de A0h / 0EFh  80 bytes de proposito general banco 1
;de 120h/16fh   80 bytes de proposito general banco 2
 
temp equ 20h 
 
;ToDO :
;addicionar los tiempos de un segundo,a tres segundos 
;addicionar la conversion de AD
;Averiguar sobre la comunicacion.
 
; ************  Proteus Isis Configuration File
 
list p=16f877 ;it specify the class of pic.
;it is posible replace the inc files doing the proper asignation.see above.
;this values are used by the mpasm,asemp compilers
;when you're   enabling the enviroment values you can 
;use each one instruction inside the Pic,as you now you could 
;modify these options by next to parameters :
 
 
 
 
;_OPTION_CLASS_ONOROFF 
 
 
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
;xt oscilator,power on reset on,watchdog timer off,copy protection off
 
;#####Main############
 
org 0x000
goto start

