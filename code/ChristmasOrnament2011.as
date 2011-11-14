opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 10920"

opt pagewidth 120

	opt lm

	processor	16F505
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
# 5 "C:\projects-hg\christmasornament2011\code\main.c"
	psect config,class=CONFIG,delta=2 ;#
# 5 "C:\projects-hg\christmasornament2011\code\main.c"
	dw 0xFFFC & 0xFFF7 & 0xFFFF & 0xFFFF ;#
	FNCALL	_main,_rand
	FNCALL	_rand,_srand
	FNCALL	_rand,___lmul
	FNROOT	_main
	global	_inhibitModeChange
psect	idataBANK1,class=ENTRY,space=0,delta=2
global __pidataBANK1
__pidataBANK1:
	file	"C:\projects-hg\christmasornament2011\code\main.c"
	line	12

;initializer for _inhibitModeChange
	retlw	01h
	global	_randx
	global	_randomNum
	global	_softwareTimer
	global	_currentMode
	global	_displayState
	global	_newPortB
	global	_newPortC
	global	_randf
	global	_scratchPad
	global	_switchState
	global	_OPTION
_OPTION	set	0
	global	_PORTB
_PORTB	set	6
	global	_PORTC
_PORTC	set	7
	global	_TRISB
_TRISB	set	6
	global	_TRISC
_TRISC	set	7
	file	"ChristmasOrnament2011.as"
	line	#
psect cinit,class=ENTRY,delta=2
global start_initialization
start_initialization:

psect	bssBANK1,class=BANK1,space=1
global __pbssBANK1
__pbssBANK1:
_randomNum:
       ds      2

_softwareTimer:
       ds      2

_currentMode:
       ds      1

_displayState:
       ds      1

_newPortB:
       ds      1

_newPortC:
       ds      1

_randf:
       ds      1

_scratchPad:
       ds      1

_switchState:
       ds      1

psect	dataBANK1,class=BANK1,space=1
global __pdataBANK1
__pdataBANK1:
	file	"C:\projects-hg\christmasornament2011\code\main.c"
_inhibitModeChange:
       ds      1

psect	bssBANK3,class=BANK3,space=1
global __pbssBANK3
__pbssBANK3:
_randx:
       ds      4

psect clrtext,class=ENTRY,delta=2
global clear_ram
;	Called with FSR containing the base address, and
;	W with the last address+1
clear_ram:
	clrwdt			;clear the watchdog before getting into this loop
clrloop:
	clrf	indf		;clear RAM location pointed to by FSR
	incf	fsr,f		;increment pointer
	xorwf	fsr,w		;XOR with final address
	andlw	1Fh		;Test low bits only
	btfsc	status,2	;have we reached the end yet?
	retlw	0		;all done for this memory range, return
	xorwf	fsr,w		;XOR again to restore value
	goto	clrloop		;do the next byte

; Clear objects allocated to BANK1
psect cinit,class=ENTRY,delta=2
	movlw	__pbssBANK1
	movwf	fsr
	movlw	((__pbssBANK1)+0Bh)&0xFF
	fcall	clear_ram
; Clear objects allocated to BANK3
psect cinit,class=ENTRY,delta=2
	movlw	__pbssBANK3
	movwf	fsr
	movlw	((__pbssBANK3)+04h)&0xFF
	fcall	clear_ram
; Initialize objects allocated to BANK1
	global __pidataBANK1
psect cinit,class=ENTRY,delta=2
	bsf	fsr,5	;FSR5=1, select bank1
	bcf	fsr,6	;FSR6=0, select bank1
	fcall	__pidataBANK1+0		;fetch initializer
	movwf	__pdataBANK1+0&01fh
psect cinit,class=ENTRY,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf fsr
ljmp _main	;jump to C main() function
psect	cstackBANK1,class=BANK1,space=1
global __pcstackBANK1
__pcstackBANK1:
	global	??_main
??_main:	; 0 bytes @ 0x0
	ds	1
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_srand
?_srand:	; 0 bytes @ 0x0
	global	?___lmul
?___lmul:	; 4 bytes @ 0x0
	global	srand@x
srand@x:	; 2 bytes @ 0x0
	global	___lmul@multiplier
___lmul@multiplier:	; 4 bytes @ 0x0
	ds	2
	global	??_srand
??_srand:	; 0 bytes @ 0x2
	ds	2
	global	___lmul@multiplicand
___lmul@multiplicand:	; 4 bytes @ 0x4
	ds	4
	global	??___lmul
??___lmul:	; 0 bytes @ 0x8
	ds	1
	global	___lmul@product
___lmul@product:	; 4 bytes @ 0x9
	ds	4
	global	?_rand
?_rand:	; 2 bytes @ 0xD
	ds	2
	global	??_rand
??_rand:	; 0 bytes @ 0xF
	ds	1
;;Data sizes: Strings 0, constant 0, data 1, bss 15, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; BANK0           16     16      16
;; BANK1           16      1      13
;; BANK3           16      0       4
;; BANK2           16      0       0
;; COMMON           0      0       0

;;
;; Pointer list with targets:

;; ?_rand	int  size(1) Largest target is 0
;;
;; ?___lmul	unsigned long  size(1) Largest target is 0
;;


;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_rand
;;   _rand->___lmul
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.
;;
;; Critical Paths under _main in COMMON
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 1, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 1     1      0     114
;;                                              0 BANK1      1     1      0
;;                               _rand
;; ---------------------------------------------------------------------------------
;; (1) _rand                                                 3     1      2     114
;;                                             13 BANK0      3     1      2
;;                              _srand
;;                             ___lmul
;; ---------------------------------------------------------------------------------
;; (2) ___lmul                                              13     5      8      92
;;                                              0 BANK0     13     5      8
;; ---------------------------------------------------------------------------------
;; (2) _srand                                                2     0      2      22
;;                                              0 BANK0      2     0      2
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _rand
;;     _srand
;;     ___lmul
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;STACK                0      0       2       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;ABS                  0      0      21       1        0.0%
;;BITBANK0            10      0       0       2        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;BANK0               10     10      10       3      100.0%
;;BITBANK1            10      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK1               10      1       D       5       81.3%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;DATA                 0      0      23       6        0.0%
;;BITBANK3            10      0       0       7        0.0%
;;BANK3               10      0       4       8       25.0%
;;BITBANK2            10      0       0       9        0.0%
;;BANK2               10      0       0      10        0.0%
;;BITCOMMON            0      0       0      11        0.0%
;;COMMON               0      0       0      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 17 in file "C:\projects-hg\christmasornament2011\code\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+0, btemp+1, btemp+2, btemp+3, btemp+4, btemp+5, btemp+6, btemp+7, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:      BANK0   BANK1   BANK3   BANK2  COMMON
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       1       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_rand
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\projects-hg\christmasornament2011\code\main.c"
	line	17
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 0
; Regs used in _main: [wreg-fsr0h+status,2-btemp+7+pclath+cstack]
	line	19
	
l1635:	
;main.c: 19: OPTION = 0b01000111;
	movlw	(047h)
	option
	line	21
;main.c: 21: TRISC = 0x00;
	movlw	0
	tris	0x7
	line	22
;main.c: 22: TRISB = 0x01;
	movlw	(01h)
	tris	0x6
	line	23
	
l1637:	
;main.c: 23: PORTC = 0x00;
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	clrf	(7)	;volatile
	line	24
	
l1639:	
;main.c: 24: PORTB = 0x00;
	clrf	(6)	;volatile
	goto	l1641
	line	27
;main.c: 27: while(1) {
	
l107:	
	line	30
	
l1641:	
;main.c: 30: PORTB = newPortB;
	bsf	fsr,5	;FSR5=1, select bank1
	movf	(_newPortB)^020h,w
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	31
	
l1643:	
;main.c: 31: PORTC = newPortC;
	bsf	fsr,5	;FSR5=1, select bank1
	movf	(_newPortC)^020h,w
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(7)	;volatile
	line	32
	
l1645:	
;main.c: 32: _delay((unsigned long)((50)*(4000000/4000000.0)));
	opt asmopt_off
movlw	16
	bsf	fsr,5	;FSR5=1, select bank1
movwf	(??_main+0)^020h+0,f
u2767:
decfsz	(??_main+0)^020h+0,f
	goto	u2767
	clrwdt
opt asmopt_on

	line	33
	
l1647:	
;main.c: 33: PORTB = 0;
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	clrf	(6)	;volatile
	line	34
	
l1649:	
;main.c: 34: PORTC = 0;
	clrf	(7)	;volatile
	line	35
	
l1651:	
;main.c: 35: _delay((unsigned long)((50)*(4000000/4000000.0)));
	opt asmopt_off
movlw	16
	bsf	fsr,5	;FSR5=1, select bank1
movwf	(??_main+0)^020h+0,f
u2777:
decfsz	(??_main+0)^020h+0,f
	goto	u2777
	clrwdt
opt asmopt_on

	line	36
	
l1653:	
;main.c: 36: _delay((unsigned long)((250)*(4000000/4000000.0)));
	opt asmopt_off
movlw	83
	bsf	fsr,5	;FSR5=1, select bank1
	bcf	fsr,6	;FSR6=0, select bank1
movwf	(??_main+0)^020h+0,f
u2787:
decfsz	(??_main+0)^020h+0,f
	goto	u2787
opt asmopt_on

	line	37
	
l1655:	
;main.c: 37: _delay((unsigned long)((250)*(4000000/4000000.0)));
	opt asmopt_off
movlw	83
	bsf	fsr,5	;FSR5=1, select bank1
	bcf	fsr,6	;FSR6=0, select bank1
movwf	(??_main+0)^020h+0,f
u2797:
decfsz	(??_main+0)^020h+0,f
	goto	u2797
opt asmopt_on

	line	38
	
l1657:	
;main.c: 38: softwareTimer++;
	movlw	01h
	movwf	btemp+6
	clrf	btemp+7
	movf	0+wtemp3,w
	bsf	fsr,5	;FSR5=1, select bank1
	bcf	fsr,6	;FSR6=0, select bank1
	addwf	(_softwareTimer)^020h,f
	skipnc
	incf	(_softwareTimer+1)^020h,f
	movf	1+wtemp3,w
	addwf	(_softwareTimer+1)^020h,f
	line	42
	
l1659:	
;main.c: 42: if(switchState == 0) {
	movf	(_switchState)^020h,f
	skipz
	goto	u2531
	goto	u2530
u2531:
	goto	l1667
u2530:
	line	45
	
l1661:	
;main.c: 45: if(!(PORTB & 0x01)) {
	bcf	fsr,5	;FSR5=0, select bank0
	btfsc	(6),(0)&7
	goto	u2541
	goto	u2540
u2541:
	goto	l1665
u2540:
	line	46
	
l1663:	
;main.c: 46: switchState = 1;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_switchState)^020h
	bsf	status,0
	rlf	(_switchState)^020h,f
	line	47
;main.c: 47: } else {
	goto	l1821
	
l109:	
	line	48
	
l1665:	
;main.c: 48: switchState = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_switchState)^020h
	goto	l1821
	line	49
	
l110:	
	line	50
;main.c: 49: }
;main.c: 50: } else if(switchState == 1) {
	goto	l1821
	
l108:	
	
l1667:	
	movf	(_switchState)^020h,w
	xorlw	01h
	skipz
	goto	u2551
	goto	u2550
u2551:
	goto	l1675
u2550:
	line	52
	
l1669:	
;main.c: 52: if(!(PORTB & 0x01)) {
	bcf	fsr,5	;FSR5=0, select bank0
	btfsc	(6),(0)&7
	goto	u2561
	goto	u2560
u2561:
	goto	l1673
u2560:
	line	53
	
l1671:	
;main.c: 53: switchState = 2;
	movlw	(02h)
	bsf	fsr,5	;FSR5=1, select bank1
	movwf	(_switchState)^020h
	line	54
;main.c: 54: } else {
	goto	l1821
	
l113:	
	line	55
	
l1673:	
;main.c: 55: switchState = 1;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_switchState)^020h
	bsf	status,0
	rlf	(_switchState)^020h,f
	goto	l1821
	line	56
	
l114:	
	line	57
;main.c: 56: }
;main.c: 57: } else if(switchState == 2) {
	goto	l1821
	
l112:	
	
l1675:	
	movf	(_switchState)^020h,w
	xorlw	02h
	skipz
	goto	u2571
	goto	u2570
u2571:
	goto	l1695
u2570:
	line	59
	
l1677:	
;main.c: 59: if(PORTB & 0x01) {
	bcf	fsr,5	;FSR5=0, select bank0
	btfss	(6),(0)&7
	goto	u2581
	goto	u2580
u2581:
	goto	l1693
u2580:
	line	60
	
l1679:	
;main.c: 60: if(inhibitModeChange) {
	bsf	fsr,5	;FSR5=1, select bank1
	movf	(_inhibitModeChange)^020h,w
	skipz
	goto	u2590
	goto	l1683
u2590:
	line	61
	
l1681:	
;main.c: 61: inhibitModeChange = 0;
	clrf	(_inhibitModeChange)^020h
	line	62
;main.c: 62: } else {
	goto	l1691
	
l118:	
	line	63
	
l1683:	
;main.c: 63: currentMode++;
	movlw	(01h)
	movwf	btemp+7
	movf	btemp+7,w
	addwf	(_currentMode)^020h,f
	line	64
	
l1685:	
;main.c: 64: if(currentMode > 8) currentMode = 0;
	movlw	(09h)
	subwf	(_currentMode)^020h,w
	skipc
	goto	u2601
	goto	u2600
u2601:
	goto	l120
u2600:
	
l1687:	
	clrf	(_currentMode)^020h
	
l120:	
	line	65
;main.c: 65: displayState = 0;
	clrf	(_displayState)^020h
	line	66
	
l1689:	
;main.c: 66: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	clrf	(_softwareTimer+1)^020h
	goto	l1691
	line	67
	
l119:	
	line	68
	
l1691:	
;main.c: 67: }
;main.c: 68: switchState = 0;
	clrf	(_switchState)^020h
	line	69
;main.c: 69: } else {
	goto	l1821
	
l117:	
	line	70
	
l1693:	
;main.c: 70: switchState = 2;
	movlw	(02h)
	bsf	fsr,5	;FSR5=1, select bank1
	movwf	(_switchState)^020h
	goto	l1821
	line	71
	
l121:	
	line	72
;main.c: 71: }
;main.c: 72: } else {
	goto	l1821
	
l116:	
	line	73
	
l1695:	
;main.c: 73: switchState = 0;
	clrf	(_switchState)^020h
	goto	l1821
	line	74
	
l122:	
	goto	l1821
	
l115:	
	goto	l1821
	
l111:	
	line	77
;main.c: 74: }
;main.c: 77: switch(currentMode) {
	goto	l1821
	line	78
;main.c: 78: case 0:
	
l124:	
	line	79
	
l1697:	
;main.c: 79: if(softwareTimer >= 8) {
	movlw	high(08h)
	subwf	(_softwareTimer+1)^020h,w
	movlw	low(08h)
	skipnz
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2611
	goto	u2610
u2611:
	goto	l1641
u2610:
	line	80
	
l1699:	
;main.c: 80: newPortB = 0b00110100;
	movlw	(034h)
	movwf	(_newPortB)^020h
	line	81
;main.c: 81: newPortC = 0b00111111;
	movlw	(03Fh)
	movwf	(_newPortC)^020h
	line	82
	
l1701:	
;main.c: 82: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	clrf	(_softwareTimer+1)^020h
	goto	l1641
	line	83
	
l125:	
	line	84
;main.c: 83: }
;main.c: 84: break;
	goto	l1641
	line	85
;main.c: 85: case 1:
	
l127:	
	line	86
	
l1703:	
;main.c: 86: if(softwareTimer >= 800) {
	movlw	high(0320h)
	subwf	(_softwareTimer+1)^020h,w
	movlw	low(0320h)
	skipnz
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2621
	goto	u2620
u2621:
	goto	l1641
u2620:
	line	87
	
l1705:	
;main.c: 87: if(displayState == 0) {
	movf	(_displayState)^020h,f
	skipz
	goto	u2631
	goto	u2630
u2631:
	goto	l1711
u2630:
	line	88
	
l1707:	
;main.c: 88: newPortB = 0b00110100;
	movlw	(034h)
	movwf	(_newPortB)^020h
	line	89
;main.c: 89: newPortC = 0b00111111;
	movlw	(03Fh)
	movwf	(_newPortC)^020h
	line	90
	
l1709:	
;main.c: 90: displayState = 1;
	clrf	(_displayState)^020h
	bsf	status,0
	rlf	(_displayState)^020h,f
	line	91
;main.c: 91: } else {
	goto	l1713
	
l129:	
	line	92
	
l1711:	
;main.c: 92: newPortB = 0x00;
	clrf	(_newPortB)^020h
	line	93
;main.c: 93: newPortC = 0x00;
	clrf	(_newPortC)^020h
	line	94
;main.c: 94: displayState = 0;
	clrf	(_displayState)^020h
	goto	l1713
	line	95
	
l130:	
	line	96
	
l1713:	
;main.c: 95: }
;main.c: 96: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	clrf	(_softwareTimer+1)^020h
	goto	l1641
	line	97
	
l128:	
	line	98
;main.c: 97: }
;main.c: 98: break;
	goto	l1641
	line	99
;main.c: 99: case 2:
	
l131:	
	line	100
	
l1715:	
;main.c: 100: if(softwareTimer >= 800) {
	movlw	high(0320h)
	subwf	(_softwareTimer+1)^020h,w
	movlw	low(0320h)
	skipnz
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2641
	goto	u2640
u2641:
	goto	l1641
u2640:
	line	101
	
l1717:	
;main.c: 101: if(displayState == 0) {
	movf	(_displayState)^020h,f
	skipz
	goto	u2651
	goto	u2650
u2651:
	goto	l1723
u2650:
	line	102
	
l1719:	
;main.c: 102: newPortB = 0b00000100;
	movlw	(04h)
	movwf	(_newPortB)^020h
	line	103
;main.c: 103: newPortC = 0b00101110;
	movlw	(02Eh)
	movwf	(_newPortC)^020h
	line	104
	
l1721:	
;main.c: 104: displayState = 1;
	clrf	(_displayState)^020h
	bsf	status,0
	rlf	(_displayState)^020h,f
	line	105
;main.c: 105: } else {
	goto	l1727
	
l133:	
	line	106
	
l1723:	
;main.c: 106: newPortB = 0b00110000;
	movlw	(030h)
	movwf	(_newPortB)^020h
	line	107
;main.c: 107: newPortC = 0b00010001;
	movlw	(011h)
	movwf	(_newPortC)^020h
	line	108
	
l1725:	
;main.c: 108: displayState = 0;
	clrf	(_displayState)^020h
	goto	l1727
	line	109
	
l134:	
	line	110
	
l1727:	
;main.c: 109: }
;main.c: 110: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	clrf	(_softwareTimer+1)^020h
	goto	l1641
	line	111
	
l132:	
	line	112
;main.c: 111: }
;main.c: 112: break;
	goto	l1641
	line	113
;main.c: 113: case 3:
	
l135:	
	line	114
	
l1729:	
;main.c: 114: if(softwareTimer >= 400) {
	movlw	high(0190h)
	subwf	(_softwareTimer+1)^020h,w
	movlw	low(0190h)
	skipnz
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2661
	goto	u2660
u2661:
	goto	l1641
u2660:
	line	115
	
l1731:	
;main.c: 115: if(displayState == 0) {
	movf	(_displayState)^020h,f
	skipz
	goto	u2671
	goto	u2670
u2671:
	goto	l1739
u2670:
	line	116
	
l1733:	
;main.c: 116: newPortB = 0b00000000;
	clrf	(_newPortB)^020h
	line	117
	
l1735:	
;main.c: 117: newPortC = 0b00010110;
	movlw	(016h)
	movwf	(_newPortC)^020h
	line	118
	
l1737:	
;main.c: 118: displayState = 1;
	clrf	(_displayState)^020h
	bsf	status,0
	rlf	(_displayState)^020h,f
	line	119
;main.c: 119: } else if(displayState == 1) {
	goto	l1747
	
l137:	
	
l1739:	
	movf	(_displayState)^020h,w
	xorlw	01h
	skipz
	goto	u2681
	goto	u2680
u2681:
	goto	l1743
u2680:
	line	120
	
l1741:	
;main.c: 120: newPortB = 0b00100000;
	movlw	(020h)
	movwf	(_newPortB)^020h
	line	121
;main.c: 121: newPortC = 0b00100001;
	movlw	(021h)
	movwf	(_newPortC)^020h
	line	122
;main.c: 122: displayState = 2;
	movlw	(02h)
	movwf	(_displayState)^020h
	line	123
;main.c: 123: } else {
	goto	l1747
	
l139:	
	line	124
	
l1743:	
;main.c: 124: newPortB = 0b00010100;
	movlw	(014h)
	movwf	(_newPortB)^020h
	line	125
;main.c: 125: newPortC = 0b00001000;
	movlw	(08h)
	movwf	(_newPortC)^020h
	line	126
	
l1745:	
;main.c: 126: displayState = 0;
	clrf	(_displayState)^020h
	goto	l1747
	line	127
	
l140:	
	goto	l1747
	
l138:	
	line	128
	
l1747:	
;main.c: 127: }
;main.c: 128: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	clrf	(_softwareTimer+1)^020h
	goto	l1641
	line	129
	
l136:	
	line	130
;main.c: 129: }
;main.c: 130: break;
	goto	l1641
	line	131
;main.c: 131: case 4:
	
l141:	
	line	132
	
l1749:	
;main.c: 132: if(softwareTimer >= 400) {
	movlw	high(0190h)
	subwf	(_softwareTimer+1)^020h,w
	movlw	low(0190h)
	skipnz
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2691
	goto	u2690
u2691:
	goto	l1641
u2690:
	line	133
	
l1751:	
;main.c: 133: if(displayState == 0) {
	movf	(_displayState)^020h,f
	skipz
	goto	u2701
	goto	u2700
u2701:
	goto	l1757
u2700:
	line	134
	
l1753:	
;main.c: 134: newPortB = 0b00000100;
	movlw	(04h)
	movwf	(_newPortB)^020h
	line	135
;main.c: 135: newPortC = 0b00010111;
	movlw	(017h)
	movwf	(_newPortC)^020h
	line	136
	
l1755:	
;main.c: 136: displayState = 1;
	clrf	(_displayState)^020h
	bsf	status,0
	rlf	(_displayState)^020h,f
	line	137
;main.c: 137: } else if(displayState == 1) {
	goto	l1765
	
l143:	
	
l1757:	
	movf	(_displayState)^020h,w
	xorlw	01h
	skipz
	goto	u2711
	goto	u2710
u2711:
	goto	l1761
u2710:
	line	138
	
l1759:	
;main.c: 138: newPortB = 0b00100100;
	movlw	(024h)
	movwf	(_newPortB)^020h
	line	139
;main.c: 139: newPortC = 0b00100011;
	movlw	(023h)
	movwf	(_newPortC)^020h
	line	140
;main.c: 140: displayState = 2;
	movlw	(02h)
	movwf	(_displayState)^020h
	line	141
;main.c: 141: } else {
	goto	l1765
	
l145:	
	line	142
	
l1761:	
;main.c: 142: newPortB = 0b00010100;
	movlw	(014h)
	movwf	(_newPortB)^020h
	line	143
;main.c: 143: newPortC = 0b00001011;
	movlw	(0Bh)
	movwf	(_newPortC)^020h
	line	144
	
l1763:	
;main.c: 144: displayState = 0;
	clrf	(_displayState)^020h
	goto	l1765
	line	145
	
l146:	
	goto	l1765
	
l144:	
	line	146
	
l1765:	
;main.c: 145: }
;main.c: 146: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	clrf	(_softwareTimer+1)^020h
	goto	l1641
	line	147
	
l142:	
	line	148
;main.c: 147: }
;main.c: 148: break;
	goto	l1641
	line	149
;main.c: 149: case 5:
	
l147:	
	line	150
	
l1767:	
;main.c: 150: if(softwareTimer >= 800) {
	movlw	high(0320h)
	subwf	(_softwareTimer+1)^020h,w
	movlw	low(0320h)
	skipnz
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2721
	goto	u2720
u2721:
	goto	l1641
u2720:
	line	151
	
l1769:	
;main.c: 151: if(displayState == 0) {
	movf	(_displayState)^020h,f
	skipz
	goto	u2731
	goto	u2730
u2731:
	goto	l1775
u2730:
	line	152
	
l1771:	
;main.c: 152: newPortB = 0b00110100;
	movlw	(034h)
	movwf	(_newPortB)^020h
	line	153
;main.c: 153: newPortC = 0b00111111;
	movlw	(03Fh)
	movwf	(_newPortC)^020h
	line	154
	
l1773:	
;main.c: 154: displayState = 1;
	clrf	(_displayState)^020h
	bsf	status,0
	rlf	(_displayState)^020h,f
	line	155
;main.c: 155: } else {
	goto	l1779
	
l149:	
	line	156
	
l1775:	
;main.c: 156: newPortB = 0b00000100;
	movlw	(04h)
	movwf	(_newPortB)^020h
	line	157
;main.c: 157: newPortC = 0b00000011;
	movlw	(03h)
	movwf	(_newPortC)^020h
	line	158
	
l1777:	
;main.c: 158: displayState = 0;
	clrf	(_displayState)^020h
	goto	l1779
	line	159
	
l150:	
	line	160
	
l1779:	
;main.c: 159: }
;main.c: 160: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	clrf	(_softwareTimer+1)^020h
	goto	l1641
	line	161
	
l148:	
	line	162
;main.c: 161: }
;main.c: 162: break;
	goto	l1641
	line	163
;main.c: 163: case 6:
	
l151:	
	line	164
	
l1781:	
;main.c: 164: if(softwareTimer >= 200) {
	movlw	high(0C8h)
	subwf	(_softwareTimer+1)^020h,w
	movlw	low(0C8h)
	skipnz
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2741
	goto	u2740
u2741:
	goto	l1641
u2740:
	line	165
	
l1783:	
;main.c: 165: randomNum = rand();
	fcall	entry__rand
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	movf	(1+(?_rand)),w
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_randomNum+1)^020h
	addwf	(_randomNum+1)^020h
	bcf	fsr,5	;FSR5=0, select bank0
	movf	(0+(?_rand)),w
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_randomNum)^020h
	addwf	(_randomNum)^020h

	line	166
	
l1785:	
;main.c: 166: newPortB = (unsigned char) (((randomNum & 0xFF00) >> 8) & 0b00110100);
	movf	(_randomNum+1)^020h,w
	movwf	btemp+7
	movf	(_randomNum)^020h,w
	movwf	btemp+6
	movf	1+wtemp3,w
	andlw	034h
	movwf	(_newPortB)^020h
	line	167
	
l1787:	
;main.c: 167: newPortC = (unsigned char) ((randomNum & 0x00FF) & 0b00111111);
	movf	(_randomNum)^020h,w
	andlw	03Fh
	movwf	(_newPortC)^020h
	line	168
	
l1789:	
;main.c: 168: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	clrf	(_softwareTimer+1)^020h
	goto	l1641
	line	169
	
l152:	
	line	170
;main.c: 169: }
;main.c: 170: break;
	goto	l1641
	line	171
;main.c: 171: case 7:
	
l153:	
	line	172
	
l1791:	
;main.c: 172: if(softwareTimer >= 200) {
	movlw	high(0C8h)
	subwf	(_softwareTimer+1)^020h,w
	movlw	low(0C8h)
	skipnz
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2751
	goto	u2750
u2751:
	goto	l1641
u2750:
	line	173
	
l1793:	
;main.c: 173: randomNum = rand();
	fcall	entry__rand
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	movf	(1+(?_rand)),w
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_randomNum+1)^020h
	addwf	(_randomNum+1)^020h
	bcf	fsr,5	;FSR5=0, select bank0
	movf	(0+(?_rand)),w
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_randomNum)^020h
	addwf	(_randomNum)^020h

	line	174
	
l1795:	
;main.c: 174: scratchPad = (unsigned char) (((randomNum & 0xFF00) >> 8) & 0b00110100);
	movf	(_randomNum+1)^020h,w
	movwf	btemp+7
	movf	(_randomNum)^020h,w
	movwf	btemp+6
	movf	1+wtemp3,w
	andlw	034h
	movwf	(_scratchPad)^020h
	line	175
	
l1797:	
;main.c: 175: scratchPad |= 0b00000100;
	bsf	(_scratchPad)^020h+(2/8),(2)&7
	line	176
	
l1799:	
;main.c: 176: newPortB = scratchPad;
	movf	(_scratchPad)^020h,w
	movwf	(_newPortB)^020h
	line	177
	
l1801:	
;main.c: 177: scratchPad = (unsigned char) ((randomNum & 0x00FF) & 0b00111111);
	movf	(_randomNum)^020h,w
	andlw	03Fh
	movwf	(_scratchPad)^020h
	line	178
	
l1803:	
;main.c: 178: scratchPad |= 0b00000011;
	movlw	(03h)
	movwf	btemp+7
	movf	btemp+7,w
	iorwf	(_scratchPad)^020h,f
	line	179
	
l1805:	
;main.c: 179: newPortC = scratchPad;
	movf	(_scratchPad)^020h,w
	movwf	(_newPortC)^020h
	line	180
	
l1807:	
;main.c: 180: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	clrf	(_softwareTimer+1)^020h
	goto	l1641
	line	181
	
l154:	
	line	182
;main.c: 181: }
;main.c: 182: break;
	goto	l1641
	line	183
;main.c: 183: case 8:
	
l155:	
	line	184
	
l1809:	
;main.c: 184: PORTB = 0;
	bcf	fsr,5	;FSR5=0, select bank0
	clrf	(6)	;volatile
	line	185
;main.c: 185: PORTC = 0;
	clrf	(7)	;volatile
	line	188
	
l1811:	
# 188 "C:\projects-hg\christmasornament2011\code\main.c"
     SLEEP ;#
psect	maintext
	line	190
	
l1813:	
# 190 "C:\projects-hg\christmasornament2011\code\main.c"
# 189 ;#
psect	maintext
	line	192
	
l1815:	
;main.c: 192: currentMode = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	bcf	fsr,6	;FSR6=0, select bank1
	clrf	(_currentMode)^020h
	line	193
;main.c: 193: break;
	goto	l1641
	line	194
;main.c: 194: default:
	
l156:	
	line	195
	
l1817:	
;main.c: 195: currentMode = 0;
	clrf	(_currentMode)^020h
	line	196
;main.c: 196: break;
	goto	l1641
	line	197
	
l1819:	
;main.c: 197: }
	goto	l1641
	line	77
	
l123:	
	
l1821:	
	movf	(_currentMode)^020h,w
	; Switch size 1, requested type "space"
; Number of cases is 9, Range of values is 0 to 8
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           28    15 (average)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l1697
	xorlw	1^0	; case 1
	skipnz
	goto	l1703
	xorlw	2^1	; case 2
	skipnz
	goto	l1715
	xorlw	3^2	; case 3
	skipnz
	goto	l1729
	xorlw	4^3	; case 4
	skipnz
	goto	l1749
	xorlw	5^4	; case 5
	skipnz
	goto	l1767
	xorlw	6^5	; case 6
	skipnz
	goto	l1781
	xorlw	7^6	; case 7
	skipnz
	goto	l1791
	xorlw	8^7	; case 8
	skipnz
	goto	l1809
	goto	l1817
	opt asmopt_on

	line	197
	
l126:	
	goto	l1641
	line	199
	
l157:	
	line	27
	goto	l1641
	
l158:	
	line	200
	
l159:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_rand
psect	text160,local,class=CODE,delta=2
global __ptext160
__ptext160:

;; *************** function _rand *****************
;; Defined at:
;;		line 14 in file "../../common/rand.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2   13[BANK0 ] int 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+0, btemp+1, btemp+2, btemp+3, btemp+4, btemp+5, btemp+6, btemp+7, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:      BANK0   BANK1   BANK3   BANK2  COMMON
;;      Params:         2       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_srand
;;		___lmul
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text160
	file	"C:\Program Files\HI-TECH Software\PICC\9.83\sources\rand.c"
	line	14
	global	__size_of_rand
	__size_of_rand	equ	__end_of_rand-_rand
	
_rand:	
	opt	stack 0
; Regs used in _rand: [wreg-fsr0h+status,2-btemp+7+pclath+cstack]
psect	jmp_tab,class=ENTRY,delta=2
global __pjmp_tab
__pjmp_tab:
	global	entry__rand
entry__rand:
	ljmp	_rand

psect	text160
	line	15
	
l1627:	
	bsf	fsr,5	;FSR5=1, select bank1
	bcf	fsr,6	;FSR6=0, select bank1
	movf	(_randf)^020h,f
	skipz
	goto	u2501
	goto	u2500
u2501:
	goto	l1631
u2500:
	line	16
	
l1629:	
	movlw	low(01h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(?_srand)
	movlw	high(01h)
	movwf	((?_srand))+1
	fcall	entry__srand
	goto	l1631
	
l169:	
	line	17
	
l1631:	
	bsf	fsr,5	;FSR5=1, select bank3
	bsf	fsr,6	;FSR6=1, select bank3
	movf	(_randx)^060h,w
	movwf	ltemp1
	movf	(_randx+1)^060h,w
	movwf	(ltemp1+1)
	movf	(_randx+2)^060h,w
	movwf	(ltemp1+2)
	movf	(_randx+3)^060h,w
	movwf	(ltemp1+3)
	movf	3+ltemp1,w
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	movwf	(?___lmul+3)
	movf	2+ltemp1,w
	movwf	(?___lmul+2)
	movf	1+ltemp1,w
	movwf	(?___lmul+1)
	movf	0+ltemp1,w
	movwf	(?___lmul)

	movlw	06Dh
	movwf	(btemp+4)
	movlw	04Eh
	movwf	(ltemp1+1)
	movlw	0C6h
	movwf	(ltemp1+2)
	movlw	041h
	movwf	(ltemp1+3)
	movf	3+ltemp1,w
	movwf	3+(?___lmul)+04h
	movf	2+ltemp1,w
	movwf	2+(?___lmul)+04h
	movf	1+ltemp1,w
	movwf	1+(?___lmul)+04h
	movf	0+ltemp1,w
	movwf	0+(?___lmul)+04h

	fcall	entry____lmul
	movlw	039h
	movwf	(btemp+4)
	movlw	030h
	movwf	(ltemp1+1)
	movlw	0
	movwf	(ltemp1+2)
	movlw	0
	movwf	(ltemp1+3)
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	movf	(0+(?___lmul)),w
	addwf	btemp+4,f
	movf	(1+(?___lmul)),w
	skipnc
	incfsz	(1+(?___lmul)),w
	goto	u2510
	goto	u2511
u2510:
	addwf	btemp+5,f
u2511:
	movf	(2+(?___lmul)),w
	skipnc
	incfsz	(2+(?___lmul)),w
	goto	u2512
	goto	u2513
u2512:
	addwf	btemp+6,f
u2513:
	movf	(3+(?___lmul)),w
	skipnc
	incf	(3+(?___lmul)),w
	addwf	btemp+7,f
	movf	3+ltemp1,w
	bsf	fsr,5	;FSR5=1, select bank3
	bsf	fsr,6	;FSR6=1, select bank3
	movwf	(_randx+3)^060h
	movf	2+ltemp1,w
	movwf	(_randx+2)^060h
	movf	1+ltemp1,w
	movwf	(_randx+1)^060h
	movf	0+ltemp1,w
	movwf	(_randx)^060h

	movf	((_randx)^060h),w
	movwf	ltemp0
	movf	((_randx+1)^060h),w
	movwf	(ltemp0+1)
	movf	((_randx+2)^060h),w
	movwf	(ltemp0+2)
	movf	((_randx+3)^060h),w
	movwf	(ltemp0+3)
	movlw	010h
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	movwf	(??_rand+0)+0
u2525:
	rlf	btemp+3,w
	rrf	btemp+3,f
	rrf	btemp+2,f
	rrf	btemp+1,f
	rrf	btemp+0,f
u2520:
	decfsz	(??_rand+0)+0,f
	goto	u2525
	movlw	low(07FFFh)
	movwf	btemp+6
	movlw	high(07FFFh)
	movwf	btemp+7
	movf	0+wtemp3,w
	andwf	0+ltemp0,w
	movwf	(?_rand)
	movf	1+wtemp3,w
	andwf	1+ltemp0,w
	movwf	1+(?_rand)
	goto	l170
	
l1633:	
	line	18
	
l170:	
	retlw 0
	opt stack 0
GLOBAL	__end_of_rand
	__end_of_rand:
;; =============== function _rand ends ============

	signat	_rand,90
	global	___lmul
psect	text161,local,class=CODE,delta=2
global __ptext161
__ptext161:

;; *************** function ___lmul *****************
;; Defined at:
;;		line 3 in file "C:\Program Files\HI-TECH Software\PICC\9.83\sources\lmul.c"
;; Parameters:    Size  Location     Type
;;  multiplier      4    0[BANK0 ] unsigned long 
;;  multiplicand    4    4[BANK0 ] unsigned long 
;; Auto vars:     Size  Location     Type
;;  product         4    9[BANK0 ] unsigned long 
;; Return value:  Size  Location     Type
;;                  4    0[BANK0 ] unsigned long 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+4, btemp+5, btemp+6, btemp+7
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:      BANK0   BANK1   BANK3   BANK2  COMMON
;;      Params:         8       0       0       0       0
;;      Locals:         4       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:        13       0       0       0       0
;;Total ram usage:       13 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_rand
;; This function uses a non-reentrant model
;;
psect	text161
	file	"C:\Program Files\HI-TECH Software\PICC\9.83\sources\lmul.c"
	line	3
	global	__size_of___lmul
	__size_of___lmul	equ	__end_of___lmul-___lmul
	
___lmul:	
	opt	stack 0
; Regs used in ___lmul: [wreg-fsr0h+status,2+status,0+btemp+4-btemp+7]
psect	jmp_tab
	global	entry____lmul
entry____lmul:
	ljmp	___lmul

psect	text161
	line	4
	
l1611:	
	movlw	0
	movwf	(btemp+4)
	movlw	0
	movwf	(ltemp1+1)
	movlw	0
	movwf	(ltemp1+2)
	movlw	0
	movwf	(ltemp1+3)
	movf	3+ltemp1,w
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	movwf	(___lmul@product+3)
	movf	2+ltemp1,w
	movwf	(___lmul@product+2)
	movf	1+ltemp1,w
	movwf	(___lmul@product+1)
	movf	0+ltemp1,w
	movwf	(___lmul@product)

	goto	l1613
	line	6
	
l254:	
	line	7
	
l1613:	
	btfss	(___lmul@multiplier),(0)&7
	goto	u2461
	goto	u2460
u2461:
	goto	l1617
u2460:
	line	8
	
l1615:	
	movf	(___lmul@multiplicand),w
	addwf	(___lmul@product),f
	movf	(___lmul@multiplicand+1),w
	skipnc
	incf	(___lmul@multiplicand+1),w
	skipz
	addwf	(___lmul@product+1),f
	movf	(___lmul@multiplicand+2),w
	skipnc
	incf	(___lmul@multiplicand+2),w
	skipz
	addwf	(___lmul@product+2),f
	movf	(___lmul@multiplicand+3),w
	skipnc
	incf	(___lmul@multiplicand+3),w
	addwf	(___lmul@product+3),f
	goto	l1617
	
l255:	
	line	9
	
l1617:	
	movlw	01h
	movwf	(??___lmul+0)+0
u2475:
	clrc
	rlf	(___lmul@multiplicand),f
	rlf	(___lmul@multiplicand+1),f
	rlf	(___lmul@multiplicand+2),f
	rlf	(___lmul@multiplicand+3),f
	decfsz	(??___lmul+0)+0,f
	goto	u2475
	line	10
	
l1619:	
	movlw	01h
	movwf	(??___lmul+0)+0
u2485:
	clrc
	rrf	(___lmul@multiplier+3),f
	rrf	(___lmul@multiplier+2),f
	rrf	(___lmul@multiplier+1),f
	rrf	(___lmul@multiplier),f
	decfsz	(??___lmul+0)+0,f
	goto	u2485

	line	11
	
l1621:	
	movf	(___lmul@multiplier),w
	movwf	ltemp1
	movf	(___lmul@multiplier+1),w
	movwf	(ltemp1+1)
	movf	(___lmul@multiplier+2),w
	movwf	(ltemp1+2)
	movf	(___lmul@multiplier+3),w
	movwf	(ltemp1+3)
	movf	3+ltemp1,w
	iorwf	2+ltemp1,w
	iorwf	1+ltemp1,w
	iorwf	0+ltemp1,w
	skipz
	goto	u2491
	goto	u2490
u2491:
	goto	l1613
u2490:
	goto	l1623
	
l256:	
	line	12
	
l1623:	
	movf	(___lmul@product),w
	movwf	ltemp1
	movf	(___lmul@product+1),w
	movwf	(ltemp1+1)
	movf	(___lmul@product+2),w
	movwf	(ltemp1+2)
	movf	(___lmul@product+3),w
	movwf	(ltemp1+3)
	movf	3+ltemp1,w
	movwf	(?___lmul+3)
	movf	2+ltemp1,w
	movwf	(?___lmul+2)
	movf	1+ltemp1,w
	movwf	(?___lmul+1)
	movf	0+ltemp1,w
	movwf	(?___lmul)

	goto	l257
	
l1625:	
	line	13
	
l257:	
	retlw 0
	opt stack 0
GLOBAL	__end_of___lmul
	__end_of___lmul:
;; =============== function ___lmul ends ============

	signat	___lmul,8316
	global	_srand
psect	text162,local,class=CODE,delta=2
global __ptext162
__ptext162:

;; *************** function _srand *****************
;; Defined at:
;;		line 8 in file "../../common/rand.c"
;; Parameters:    Size  Location     Type
;;  x               2    0[BANK0 ] unsigned int 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:      BANK0   BANK1   BANK3   BANK2  COMMON
;;      Params:         2       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_rand
;; This function uses a non-reentrant model
;;
psect	text162
	file	"C:\Program Files\HI-TECH Software\PICC\9.83\sources\rand.c"
	line	8
	global	__size_of_srand
	__size_of_srand	equ	__end_of_srand-_srand
	
_srand:	
	opt	stack 0
; Regs used in _srand: [wreg-fsr0h+status,2+status,0]
psect	jmp_tab
	global	entry__srand
entry__srand:
	ljmp	_srand

psect	text162
	line	9
	
l1607:	
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	movf	(srand@x),w
	bsf	fsr,5	;FSR5=1, select bank3
	bsf	fsr,6	;FSR6=1, select bank3
	movwf	(_randx)^060h
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	movf	(srand@x+1),w
	bsf	fsr,5	;FSR5=1, select bank3
	bsf	fsr,6	;FSR6=1, select bank3
	movwf	((_randx)^060h)+1
	clrf	2+((_randx)^060h)
	clrf	3+((_randx)^060h)
	line	10
	
l1609:	
	bcf	fsr,6	;FSR6=0, select bank1
	clrf	(_randf)^020h
	bsf	status,0
	rlf	(_randf)^020h,f
	line	11
	
l166:	
	retlw 0
	opt stack 0
GLOBAL	__end_of_srand
	__end_of_srand:
;; =============== function _srand ends ============

	signat	_srand,4216
psect	text163,local,class=CODE,delta=2
global __ptext163
__ptext163:
	global	btemp
	btemp set 08h

	DABS	1,8,8	;btemp
	global	wtemp0
	wtemp0 set btemp
	global	wtemp1
	wtemp1 set btemp+2
	global	wtemp2
	wtemp2 set btemp+4
	global	wtemp3
	wtemp3 set btemp+6
	global	ttemp0
	ttemp0 set btemp
	global	ttemp1
	ttemp1 set btemp+3
	global	ltemp0
	ltemp0 set btemp
	global	ltemp1
	ltemp1 set btemp+4
	end
