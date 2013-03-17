;Generador de Onda Cuadrada 2500 Hz 

rutina   btfss 06h,4
         goto  otro 
         btfsc 06h,4
         nop 
otro     bcf 06h,4
         movlw b'00000001'
         movwf  31h 
otro3    movlw  b'00110111'
         movwf 30h 
otro2    nop
         nop
         nop 
         nop 
         decf  30h,1
         nop
         btfss status,2
         goto otro2
         decfsz 31h,1
         goto otro3
         btfss 06h,4
         goto otro4
         btfsc  06h,4
otro4    nop
         bsf 06h,4
         movlw  b'01100011'
         movwf  30h
otro5    nop
         nop
         decfsz 30h,1
         goto otro5
         nop 
         goto rutina
;Este fue el parcial que le cae a los que no pueden asistir 
;el dia del parcial.

