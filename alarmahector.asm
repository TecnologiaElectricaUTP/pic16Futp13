;Programa:Alarma Residencial o Comercial de Pobres.
;Detalles :
;ModoS:
;[*]Vigilancia
;[*]Desactivado

;Entradas del Sistema:
;   +Interruptor de Llave para activar o desactivar RB0
;   +Sensor de Movimiento           RB1
;   +Sensor Magnetico de Puerta     RB2

;Como añadido agrego dos indicadores 
;Led Rojo alarma apagada   RB4 
;Led Verde alarma activada RB5 

;Salidas del Sistema :
;  Sirena                           RB3
;  Sms(USART-I2C)                   Por definir

;feedback:hfjimenez@utp.edu.co
;Licenced under Gpl v3 

list p=16F877A
#include P16F877A.inc

;Solo por salud defino los puertos para que duque no me diga nada :P

pa equ 05h
ta equ 85h
pb equ 06h
tb equ 86h
pc equ 07h 
tc equ 87h
pd equ 08h
td equ 88h
pe equ 09h
te equ 89h

;Defino los bits de Status 
    c  equ 0 
    dc equ 1
    z  equ 2
    pd equ 3
    T0 equ 4 
    rp0 equ 5 
    rp1 equ 6 
    irp equ 7

;Defino registros temporales en volatil mem 

temp1 equ 20h 
temp2 equ 30h 
temp3 equ 40h 
;Delays address mem 

delay equ 31h

;parte de GPR 

__CONFIG _CP_OFF & _WDT_OFF & _XT_OSC & _PWRTE_ON 

;__Config indica inicio de configuracion 
; code protection off 
; wdt  off
; oscilador xt 
; retardo en el inicio del pic 


;============== Main =================

reset  org 0x00
       clrw 
       goto start

       org 0x05
;============ Delays ================
delay1  movlw d'255' 
        movwf delay  


            
;=================Start===============

start   bcf status,rp1 ;bank1
        bsf status,rp0 ;bank0 off
        ;now we're in bank1 there is 85h,..etc

        movlw b'11111111' 
        movwf ta          ;port a inputs 
        movlw b'11110111' 
        movwf tb          ;port b {0,1,2,4,5,6,7}inputs,-{3} output sirena
        movlw b'11111111' 
        movwf tc          ;port c inputs 
        movlw b'11111111'
        movwf td          ;port d inputs 
        movlw b'11101111'
        movwf te          ;port e inputs and digital use 
        clrw              ;w starts with 0 data
        bcf status,rpo  ; bank0 on 
;TodO
;Calcular retardo de 10Segundos para alarma 
;terminarlo todo :
;Calcular retardo de 10Segundos para alarma 
;terminarlo todo :PP
