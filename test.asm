;***********************Prueba_libreria_retardos******************************
;
;
;====CONFIGURACION DEL MICROCONTROLADOR====

        List P=16F877A                    ;Especificacion del PIC
        INCLUDE     <P16F877A.INC>            ;Inclusion Archivos y Registros
        __CONFIG  _CP_OFF &  _WDT_OFF & _PWRTE_ON & _XT_OSC & _DEBUG_OFF & _WRT_OFF & _CPD_OFF & _LVP_OFF & _BODEN_ON    ;Configuracion de los Fuses 
        ;requerido por Isis!


INCLUDE <//home/user/Programacion ASM/Librerias MPLAB/Macro_Delay.INC>

CLOCK equ 4000000    ;Seleccionamos la velocidad del reloj en Hz


;====VARIABLES Y CONSTANTES====
        CBLOCK    0x20

        ENDC

;====VECTOR RESET====
Reset    
        ORG        0x00
        CLRW                       ;Limpio W .
        GOTO     Inicio
        ORG        0x04            ;Manejo de interrupciones en direccion 4
        
;====PROGRAMA PRINCIPAL====
        ORG        5
Inicio
        BCF        STATUS,RP1          ;Seleccionamos Bank0 o Bank1
        BSF        STATUS,RP0          ;Seleccionamos Bank1
        CLRF       TRISB               ;PORTB --> Out
        MOVLW      b'00111111'         ;
        MOVWF      TRISA               ;PORTA --> In
        MOVLW      0x06                ;Hacemos todas las salidas analogicas
        MOVWF      ADCON1
        BCF        STATUS,RP0          ;Seleccionamos Bank0
        CLRF       PORTB

Loop
        BSF        PORTB,0            ;Encendemos el LED en PORTB.0
        Delay_s    .1                 ;Esperamos 1 segundo
        BCF        PORTB,0            ;Apagamos el LED en PORTB.0
        Delay_s    .1                 ;Esperamos 1 segundo
        goto     Loop                 ;repetimos el bucle

INCLUDE <//home/user/Programacion ASM/Librerias MPLAB/delay_us.INC>
INCLUDE <//home/user/Programacion ASM/Librerias MPLAB/delay_ms.INC>
INCLUDE <//Programacion ASM/Librerias MPLAB/delay_s.INC>
