;==========================================================================
;
;       Revision History
;
;==========================================================================

;Rev:   Date:    Reason:
;1.03   11/17/05 Added the ADCON1 bit ADCS2.
;1.02	05/28/02 Corrected values for _CP_ALL and _CP_OFF in Configuration Bits section.
;1.01   09/13/01 Added the PIR2 bit CMIF and the PIE2 bit CMIE
;1.00   04/19/01 Initial Release (BD - generated from PIC16F877.inc)

;----- Register Files------------------------------------------------------

%define	 INDF 	0x0000
%define	 TMR0 	0x0001
%define	 PCL 	0x0002
%define	 STATUS 	0x0003
%define	 FSR 	0x0004
%define	 PORTA 	0x0005
%define	 PORTB 	0x0006
%define	 PORTC 	0x0007
%define	 PORTD 	0x0008
%define	 PORTE 	0x0009
%define	 PCLATH 	0x000A
%define	 INTCON 	0x000B
%define	 PIR1 	0x000C
%define	 PIR2 	0x000D
%define	 TMR1L 	0x000E
%define	 TMR1H 	0x000F
%define	 T1CON 	0x0010
%define	 TMR2 	0x0011
%define	 T2CON 	0x0012
%define	 SSPBUF 	0x0013
%define	 SSPCON 	0x0014
%define	 CCPR1L 	0x0015
%define	 CCPR1H 	0x0016
%define	 CCP1CON 	0x0017
%define	 RCSTA 	0x0018
%define	 TXREG 	0x0019
%define	 RCREG 	0x001A
%define	 CCPR2L 	0x001B
%define	 CCPR2H 	0x001C
%define	 CCP2CON 	0x001D
%define	 ADRESH 	0x001E
%define	 ADCON0 	0x001F

%define	 OPTION_REG 	0x0081
%define	 TRISA 	0x0085
%define	 TRISB 	0x0086
%define	 TRISC 	0x0087
%define	 TRISD 	0x0088
%define	 TRISE 	0x0089
%define	 PIE1 	0x008C
%define	 PIE2 	0x008D
%define	 PCON 	0x008E
%define	 SSPCON2 	0x0091
%define	 PR2 	0x0092
%define	 SSPADD 	0x0093
%define	 SSPSTAT 	0x0094
%define	 TXSTA 	0x0098
%define	 SPBRG 	0x0099
%define	 CMCON 	0x009C
%define	 CVRCON 	0x009D
%define	 ADRESL 	0x009E
%define	 ADCON1 	0x009F

%define	 EEDATA 	0x010C
%define	 EEADR 	0x010D
%define	 EEDATH 	0x010E
%define	 EEADRH 	0x010F

%define	 EECON1 	0x018C
%define	 EECON2 	0x018D

;----- STATUS Bits --------------------------------------------------------

%define	 IRP 	0x0007
%define	 RP1 	0x0006
%define	 RP0 	0x0005
%define	 NOT_TO 	0x0004
%define	 NOT_PD 	0x0003
%define	 Z 	0x0002
%define	 DC 	0x0001
%define	 C 	0x0000

;----- INTCON Bits --------------------------------------------------------

%define	 GIE 	0x0007
%define	 PEIE 	0x0006
%define	 T0IE 	0x0005
%define	 TMR0IE 	0x0005
%define	 INTE 	0x0004
%define	 RBIE 	0x0003
%define	 T0IF 	0x0002
%define	 TMR0IF 	0x0002
%define	 INTF 	0x0001
%define	 RBIF 	0x0000

;----- PIR1 Bits ----------------------------------------------------------

%define	 PSPIF 	0x0007
%define	 ADIF 	0x0006
%define	 RCIF 	0x0005
%define	 TXIF 	0x0004
%define	 SSPIF 	0x0003
%define	 CCP1IF 	0x0002
%define	 TMR2IF 	0x0001
%define	 TMR1IF 	0x0000

;----- PIR2 Bits ----------------------------------------------------------

%define	 CMIF 	0x0006
%define	 EEIF 	0x0004
%define	 BCLIF 	0x0003
%define	 CCP2IF 	0x0000

;----- T1CON Bits ---------------------------------------------------------

%define	 T1CKPS1 	0x0005
%define	 T1CKPS0 	0x0004
%define	 T1OSCEN 	0x0003
%define	 NOT_T1SYNC 	0x0002
%define	 T1INSYNC 	0x0002
%define	 T1SYNC 	0x0002
%define	 TMR1CS 	0x0001
%define	 TMR1ON 	0x0000

;----- T2CON Bits ---------------------------------------------------------

%define	 TOUTPS3 	0x0006
%define	 TOUTPS2 	0x0005
%define	 TOUTPS1 	0x0004
%define	 TOUTPS0 	0x0003
%define	 TMR2ON 	0x0002
%define	 T2CKPS1 	0x0001
%define	 T2CKPS0 	0x0000

;----- SSPCON Bits --------------------------------------------------------

%define	 WCOL 	0x0007
%define	 SSPOV 	0x0006
%define	 SSPEN 	0x0005
%define	 CKP 	0x0004
%define	 SSPM3 	0x0003
%define	 SSPM2 	0x0002
%define	 SSPM1 	0x0001
%define	 SSPM0 	0x0000

;----- CCP1CON Bits -------------------------------------------------------

%define	 CCP1X 	0x0005
%define	 CCP1Y 	0x0004
%define	 CCP1M3 	0x0003
%define	 CCP1M2 	0x0002
%define	 CCP1M1 	0x0001
%define	 CCP1M0 	0x0000

;----- RCSTA Bits ---------------------------------------------------------

%define	 SPEN 	0x0007
%define	 RX9 	0x0006
%define	 RC9 	0x0006
%define	 NOT_RC8 	0x0006
%define	 RC8_9 	0x0006
%define	 SREN 	0x0005
%define	 CREN 	0x0004
%define	 ADDEN 	0x0003
%define	 FERR 	0x0002
%define	 OERR 	0x0001
%define	 RX9D 	0x0000
%define	 RCD8 	0x0000

;----- CCP2CON Bits -------------------------------------------------------

%define	 CCP2X 	0x0005
%define	 CCP2Y 	0x0004
%define	 CCP2M3 	0x0003
%define	 CCP2M2 	0x0002
%define	 CCP2M1 	0x0001
%define	 CCP2M0 	0x0000

;----- ADCON0 Bits --------------------------------------------------------

%define	 ADCS1 	0x0007
%define	 ADCS0 	0x0006
%define	 CHS2 	0x0005
%define	 CHS1 	0x0004
%define	 CHS0 	0x0003
%define	 GO 	0x0002
%define	 NOT_DONE 	0x0002
%define	 GO_DONE 	0x0002
%define	 ADON 	0x0000

;----- OPTION_REG Bits -----------------------------------------------------

%define	 NOT_RBPU 	0x0007
%define	 INTEDG 	0x0006
%define	 T0CS 	0x0005
%define	 T0SE 	0x0004
%define	 PSA 	0x0003
%define	 PS2 	0x0002
%define	 PS1 	0x0001
%define	 PS0 	0x0000

;----- TRISE Bits ---------------------------------------------------------

%define	 IBF 	0x0007
%define	 OBF 	0x0006
%define	 IBOV 	0x0005
%define	 PSPMODE 	0x0004
%define	 TRISE2 	0x0002
%define	 TRISE1 	0x0001
%define	 TRISE0 	0x0000

;----- PIE1 Bits ----------------------------------------------------------

%define	 PSPIE 	0x0007
%define	 ADIE 	0x0006
%define	 RCIE 	0x0005
%define	 TXIE 	0x0004
%define	 SSPIE 	0x0003
%define	 CCP1IE 	0x0002
%define	 TMR2IE 	0x0001
%define	 TMR1IE 	0x0000

;----- PIE2 Bits ----------------------------------------------------------

%define	 CMIE 	0x0006
%define	 EEIE 	0x0004
%define	 BCLIE 	0x0003
%define	 CCP2IE 	0x0000

;----- PCON Bits ----------------------------------------------------------

%define	 NOT_POR 	0x0001
%define	 NOT_BO 	0x0000
%define	 NOT_BOR 	0x0000

;----- SSPCON2 Bits --------------------------------------------------------

%define	 GCEN 	0x0007
%define	 ACKSTAT 	0x0006
%define	 ACKDT 	0x0005
%define	 ACKEN 	0x0004
%define	 RCEN 	0x0003
%define	 PEN 	0x0002
%define	 RSEN 	0x0001
%define	 SEN 	0x0000

;----- SSPSTAT Bits -------------------------------------------------------

%define	 SMP 	0x0007
%define	 CKE 	0x0006
%define	 D 	0x0005
%define	 I2C_DATA 	0x0005
%define	 NOT_A 	0x0005
%define	 NOT_ADDRESS 	0x0005
%define	 D_A 	0x0005
%define	 DATA_ADDRESS 	0x0005
%define	 P 	0x0004
%define	 I2C_STOP 	0x0004
%define	 S 	0x0003
%define	 I2C_START 	0x0003
%define	 R 	0x0002
%define	 I2C_READ 	0x0002
%define	 NOT_W 	0x0002
%define	 NOT_WRITE 	0x0002
%define	 R_W 	0x0002
%define	 READ_WRITE 	0x0002
%define	 UA 	0x0001
%define	 BF 	0x0000

;----- TXSTA Bits ---------------------------------------------------------

%define	 CSRC 	0x0007
%define	 TX9 	0x0006
%define	 NOT_TX8 	0x0006
%define	 TX8_9 	0x0006
%define	 TXEN 	0x0005
%define	 SYNC 	0x0004
%define	 BRGH 	0x0002
%define	 TRMT 	0x0001
%define	 TX9D 	0x0000
%define	 TXD8 	0x0000


;----- CMCON Bits ---------------------------------------------------------
%define	 C2OUT 	0x0007
%define	 C1OUT 	0x0006
%define	 C2INV 	0x0005
%define	 C1INV 	0x0004
%define	 CIS 	0x0003
%define	 CM2 	0x0002
%define	 CM1 	0x0001
%define	 CM0 	0x0000

;----- CVRCON Bits --------------------------------------------------------
%define	 CVREN 	0x0007
%define	 CVROE 	0x0006
%define	 CVRR 	0x0005
%define	 CVR3 	0x0003
%define	 CVR2 	0x0002
%define	 CVR1 	0x0001
%define	 CVR0 	0x0000

;----- ADCON1 Bits --------------------------------------------------------

%define	 ADFM 	0x0007
%define	 ADCS2 	0x0006
%define	 PCFG3 	0x0003
%define	 PCFG2 	0x0002
%define	 PCFG1 	0x0001
%define	 PCFG0 	0x0000

;----- EECON1 Bits --------------------------------------------------------

%define	 EEPGD 	0x0007
%define	 WRERR 	0x0003
%define	 WREN 	0x0002
%define	 WR 	0x0001
%define	 RD 	0x0000

;==========================================================================
;
;       Configuration Bits
;
;==========================================================================

%define	 _CP_ALL 	0x1FFF
%define	 _CP_OFF 	0x3FFF
%define	 _DEBUG_OFF 	0x3FFF
%define	 _DEBUG_ON 	0x37FF
%define	 _WRT_OFF 	0x3FFF
%define	 _WRT_256 	0x3DFF
%define	 _WRT_1FOURTH 	0x3BFF
%define	 _WRT_HALF 	0x39FF
%define	 _CPD_OFF 	0x3FFF
%define	 _CPD_ON 	0x3EFF
%define	 _LVP_ON 	0x3FFF
%define	 _LVP_OFF 	0x3F7F
%define	 _BODEN_ON 	0x3FFF
%define	 _BODEN_OFF 	0x3FBF
%define	 _PWRTE_OFF 	0x3FFF
%define	 _PWRTE_ON 	0x3FF7
%define	 _WDT_ON 	0x3FFF
%define	 _WDT_OFF 	0x3FFB
%define	 _RC_OSC 	0x3FFF
%define	 _HS_OSC 	0x3FFE
%define	 _XT_OSC 	0x3FFD
%define	 _LP_OSC 	0x3FFC
