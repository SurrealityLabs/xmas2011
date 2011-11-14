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
	global	_currentMode
	global	_displayState
	global	_randf
	global	_scratchPad
	global	_softwareTimer
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
_randx:
       ds      4

_randomNum:
       ds      2

_currentMode:
       ds      1

_displayState:
       ds      1

_randf:
       ds      1

_scratchPad:
       ds      1

_softwareTimer:
       ds      1

_switchState:
       ds      1

psect	dataBANK1,class=BANK1,space=1
global __pdataBANK1
__pdataBANK1:
	file	"C:\projects-hg\christmasornament2011\code\main.c"
_inhibitModeChange:
       ds      1

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
	movlw	((__pbssBANK1)+0Ch)&0xFF
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
	ds	2
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
;;Data sizes: Strings 0, constant 0, data 1, bss 12, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; BANK0           16     16      16
;; BANK1           16      2      15
;; BANK3           16      0       0
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
;;Main: autosize = 0, tempsize = 2, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 2     2      0     114
;;                                              0 BANK1      2     2      0
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
;;ABS                  0      0      1F       1        0.0%
;;BITBANK0            10      0       0       2        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;BANK0               10     10      10       3      100.0%
;;BITBANK1            10      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK1               10      2       F       5       93.8%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;DATA                 0      0      21       6        0.0%
;;BITBANK3            10      0       0       7        0.0%
;;BANK3               10      0       0       8        0.0%
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
;;		line 15 in file "C:\projects-hg\christmasornament2011\code\main.c"
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
;;      Temps:          0       2       0       0       0
;;      Totals:         0       2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_rand
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\projects-hg\christmasornament2011\code\main.c"
	line	15
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 0
; Regs used in _main: [wreg-fsr0h+status,2-btemp+7+pclath+cstack]
	line	17
	
l1615:	
;main.c: 17: OPTION = 0b01000111;
	movlw	(047h)
	option
	line	19
;main.c: 19: TRISC = 0x00;
	movlw	0
	tris	0x7
	line	20
;main.c: 20: TRISB = 0x01;
	movlw	(01h)
	tris	0x6
	line	21
	
l1617:	
;main.c: 21: PORTC = 0x00;
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	clrf	(7)	;volatile
	line	22
	
l1619:	
;main.c: 22: PORTB = 0x00;
	clrf	(6)	;volatile
	goto	l1621
	line	25
;main.c: 25: while(1) {
	
l103:	
	line	28
	
l1621:	
;main.c: 28: _delay((unsigned long)((65)*(4000000/4000.0)));
	opt asmopt_off
movlw	85
	bsf	fsr,5	;FSR5=1, select bank1
movwf	((??_main+0)^020h+0+1),f
	movlw	105
movwf	((??_main+0)^020h+0),f
u2767:
	decfsz	((??_main+0)^020h+0),f
	goto	u2767
	decfsz	((??_main+0)^020h+0+1),f
	goto	u2767
opt asmopt_on

	line	29
	
l1623:	
;main.c: 29: softwareTimer++;
	movlw	(01h)
	movwf	btemp+7
	movf	btemp+7,w
	bsf	fsr,5	;FSR5=1, select bank1
	bcf	fsr,6	;FSR6=0, select bank1
	addwf	(_softwareTimer)^020h,f
	line	33
	
l1625:	
;main.c: 33: if(switchState == 0) {
	movf	(_switchState)^020h,f
	skipz
	goto	u2531
	goto	u2530
u2531:
	goto	l1633
u2530:
	line	36
	
l1627:	
;main.c: 36: if(!(PORTB & 0x01)) {
	bcf	fsr,5	;FSR5=0, select bank0
	btfsc	(6),(0)&7
	goto	u2541
	goto	u2540
u2541:
	goto	l1631
u2540:
	line	37
	
l1629:	
;main.c: 37: switchState = 1;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_switchState)^020h
	bsf	status,0
	rlf	(_switchState)^020h,f
	line	38
;main.c: 38: } else {
	goto	l1785
	
l105:	
	line	39
	
l1631:	
;main.c: 39: switchState = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_switchState)^020h
	goto	l1785
	line	40
	
l106:	
	line	41
;main.c: 40: }
;main.c: 41: } else if(switchState == 1) {
	goto	l1785
	
l104:	
	
l1633:	
	movf	(_switchState)^020h,w
	xorlw	01h
	skipz
	goto	u2551
	goto	u2550
u2551:
	goto	l1641
u2550:
	line	43
	
l1635:	
;main.c: 43: if(!(PORTB & 0x01)) {
	bcf	fsr,5	;FSR5=0, select bank0
	btfsc	(6),(0)&7
	goto	u2561
	goto	u2560
u2561:
	goto	l1639
u2560:
	line	44
	
l1637:	
;main.c: 44: switchState = 2;
	movlw	(02h)
	bsf	fsr,5	;FSR5=1, select bank1
	movwf	(_switchState)^020h
	line	45
;main.c: 45: } else {
	goto	l1785
	
l109:	
	line	46
	
l1639:	
;main.c: 46: switchState = 1;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_switchState)^020h
	bsf	status,0
	rlf	(_switchState)^020h,f
	goto	l1785
	line	47
	
l110:	
	line	48
;main.c: 47: }
;main.c: 48: } else if(switchState == 2) {
	goto	l1785
	
l108:	
	
l1641:	
	movf	(_switchState)^020h,w
	xorlw	02h
	skipz
	goto	u2571
	goto	u2570
u2571:
	goto	l1657
u2570:
	line	50
	
l1643:	
;main.c: 50: if(PORTB & 0x01) {
	bcf	fsr,5	;FSR5=0, select bank0
	btfss	(6),(0)&7
	goto	u2581
	goto	u2580
u2581:
	goto	l1655
u2580:
	line	51
	
l1645:	
;main.c: 51: if(inhibitModeChange) {
	bsf	fsr,5	;FSR5=1, select bank1
	movf	(_inhibitModeChange)^020h,w
	skipz
	goto	u2590
	goto	l1649
u2590:
	line	52
	
l1647:	
;main.c: 52: inhibitModeChange = 0;
	clrf	(_inhibitModeChange)^020h
	line	53
;main.c: 53: } else {
	goto	l115
	
l114:	
	line	54
	
l1649:	
;main.c: 54: currentMode++;
	movlw	(01h)
	movwf	btemp+7
	movf	btemp+7,w
	addwf	(_currentMode)^020h,f
	line	55
	
l1651:	
;main.c: 55: if(currentMode > 8) currentMode = 0;
	movlw	(09h)
	subwf	(_currentMode)^020h,w
	skipc
	goto	u2601
	goto	u2600
u2601:
	goto	l116
u2600:
	
l1653:	
	clrf	(_currentMode)^020h
	
l116:	
	line	56
;main.c: 56: displayState = 0;
	clrf	(_displayState)^020h
	line	57
;main.c: 57: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	line	58
	
l115:	
	line	59
;main.c: 58: }
;main.c: 59: switchState = 0;
	clrf	(_switchState)^020h
	line	60
;main.c: 60: } else {
	goto	l1785
	
l113:	
	line	61
	
l1655:	
;main.c: 61: switchState = 2;
	movlw	(02h)
	bsf	fsr,5	;FSR5=1, select bank1
	movwf	(_switchState)^020h
	goto	l1785
	line	62
	
l117:	
	line	63
;main.c: 62: }
;main.c: 63: } else {
	goto	l1785
	
l112:	
	line	64
	
l1657:	
;main.c: 64: switchState = 0;
	clrf	(_switchState)^020h
	goto	l1785
	line	65
	
l118:	
	goto	l1785
	
l111:	
	goto	l1785
	
l107:	
	line	68
;main.c: 65: }
;main.c: 68: switch(currentMode) {
	goto	l1785
	line	69
;main.c: 69: case 0:
	
l120:	
	line	70
	
l1659:	
;main.c: 70: if(softwareTimer >= 8) {
	movlw	(08h)
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2611
	goto	u2610
u2611:
	goto	l1621
u2610:
	line	71
	
l1661:	
;main.c: 71: PORTB = 0b00110100;
	movlw	(034h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	72
;main.c: 72: PORTC = 0b00111111;
	movlw	(03Fh)
	movwf	(7)	;volatile
	line	73
	
l1663:	
;main.c: 73: softwareTimer = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_softwareTimer)^020h
	goto	l1621
	line	74
	
l121:	
	line	75
;main.c: 74: }
;main.c: 75: break;
	goto	l1621
	line	76
;main.c: 76: case 1:
	
l123:	
	line	77
	
l1665:	
;main.c: 77: if(softwareTimer >= 8) {
	movlw	(08h)
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2621
	goto	u2620
u2621:
	goto	l1621
u2620:
	line	78
	
l1667:	
;main.c: 78: if(displayState == 0) {
	movf	(_displayState)^020h,f
	skipz
	goto	u2631
	goto	u2630
u2631:
	goto	l1673
u2630:
	line	79
	
l1669:	
;main.c: 79: PORTB = 0b00110100;
	movlw	(034h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	80
;main.c: 80: PORTC = 0b00111111;
	movlw	(03Fh)
	movwf	(7)	;volatile
	line	81
	
l1671:	
;main.c: 81: displayState = 1;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_displayState)^020h
	bsf	status,0
	rlf	(_displayState)^020h,f
	line	82
;main.c: 82: } else {
	goto	l1677
	
l125:	
	line	83
	
l1673:	
;main.c: 83: PORTB = 0x00;
	bcf	fsr,5	;FSR5=0, select bank0
	clrf	(6)	;volatile
	line	84
;main.c: 84: PORTC = 0x00;
	clrf	(7)	;volatile
	line	85
	
l1675:	
;main.c: 85: displayState = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_displayState)^020h
	goto	l1677
	line	86
	
l126:	
	line	87
	
l1677:	
;main.c: 86: }
;main.c: 87: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	goto	l1621
	line	88
	
l124:	
	line	89
;main.c: 88: }
;main.c: 89: break;
	goto	l1621
	line	90
;main.c: 90: case 2:
	
l127:	
	line	91
	
l1679:	
;main.c: 91: if(softwareTimer >= 8) {
	movlw	(08h)
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2641
	goto	u2640
u2641:
	goto	l1621
u2640:
	line	92
	
l1681:	
;main.c: 92: if(displayState == 0) {
	movf	(_displayState)^020h,f
	skipz
	goto	u2651
	goto	u2650
u2651:
	goto	l1687
u2650:
	line	93
	
l1683:	
;main.c: 93: PORTB = 0b00000100;
	movlw	(04h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	94
;main.c: 94: PORTC = 0b00101110;
	movlw	(02Eh)
	movwf	(7)	;volatile
	line	95
	
l1685:	
;main.c: 95: displayState = 1;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_displayState)^020h
	bsf	status,0
	rlf	(_displayState)^020h,f
	line	96
;main.c: 96: } else {
	goto	l1691
	
l129:	
	line	97
	
l1687:	
;main.c: 97: PORTB = 0b00110000;
	movlw	(030h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	98
;main.c: 98: PORTC = 0b00010001;
	movlw	(011h)
	movwf	(7)	;volatile
	line	99
	
l1689:	
;main.c: 99: displayState = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_displayState)^020h
	goto	l1691
	line	100
	
l130:	
	line	101
	
l1691:	
;main.c: 100: }
;main.c: 101: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	goto	l1621
	line	102
	
l128:	
	line	103
;main.c: 102: }
;main.c: 103: break;
	goto	l1621
	line	104
;main.c: 104: case 3:
	
l131:	
	line	105
	
l1693:	
;main.c: 105: if(softwareTimer >= 4) {
	movlw	(04h)
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2661
	goto	u2660
u2661:
	goto	l1621
u2660:
	line	106
	
l1695:	
;main.c: 106: if(displayState == 0) {
	movf	(_displayState)^020h,f
	skipz
	goto	u2671
	goto	u2670
u2671:
	goto	l1703
u2670:
	line	107
	
l1697:	
;main.c: 107: PORTB = 0b00000000;
	bcf	fsr,5	;FSR5=0, select bank0
	clrf	(6)	;volatile
	line	108
	
l1699:	
;main.c: 108: PORTC = 0b00010110;
	movlw	(016h)
	movwf	(7)	;volatile
	line	109
	
l1701:	
;main.c: 109: displayState = 1;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_displayState)^020h
	bsf	status,0
	rlf	(_displayState)^020h,f
	line	110
;main.c: 110: } else if(displayState == 1) {
	goto	l1711
	
l133:	
	
l1703:	
	movf	(_displayState)^020h,w
	xorlw	01h
	skipz
	goto	u2681
	goto	u2680
u2681:
	goto	l1707
u2680:
	line	111
	
l1705:	
;main.c: 111: PORTB = 0b00100000;
	movlw	(020h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	112
;main.c: 112: PORTC = 0b00100001;
	movlw	(021h)
	movwf	(7)	;volatile
	line	113
;main.c: 113: displayState = 2;
	movlw	(02h)
	bsf	fsr,5	;FSR5=1, select bank1
	movwf	(_displayState)^020h
	line	114
;main.c: 114: } else {
	goto	l1711
	
l135:	
	line	115
	
l1707:	
;main.c: 115: PORTB = 0b00010100;
	movlw	(014h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	116
;main.c: 116: PORTC = 0b00001000;
	movlw	(08h)
	movwf	(7)	;volatile
	line	117
	
l1709:	
;main.c: 117: displayState = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_displayState)^020h
	goto	l1711
	line	118
	
l136:	
	goto	l1711
	
l134:	
	line	119
	
l1711:	
;main.c: 118: }
;main.c: 119: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	goto	l1621
	line	120
	
l132:	
	line	121
;main.c: 120: }
;main.c: 121: break;
	goto	l1621
	line	122
;main.c: 122: case 4:
	
l137:	
	line	123
	
l1713:	
;main.c: 123: if(softwareTimer >= 4) {
	movlw	(04h)
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2691
	goto	u2690
u2691:
	goto	l1621
u2690:
	line	124
	
l1715:	
;main.c: 124: if(displayState == 0) {
	movf	(_displayState)^020h,f
	skipz
	goto	u2701
	goto	u2700
u2701:
	goto	l1721
u2700:
	line	125
	
l1717:	
;main.c: 125: PORTB = 0b00000100;
	movlw	(04h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	126
;main.c: 126: PORTC = 0b00010111;
	movlw	(017h)
	movwf	(7)	;volatile
	line	127
	
l1719:	
;main.c: 127: displayState = 1;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_displayState)^020h
	bsf	status,0
	rlf	(_displayState)^020h,f
	line	128
;main.c: 128: } else if(displayState == 1) {
	goto	l1729
	
l139:	
	
l1721:	
	movf	(_displayState)^020h,w
	xorlw	01h
	skipz
	goto	u2711
	goto	u2710
u2711:
	goto	l1725
u2710:
	line	129
	
l1723:	
;main.c: 129: PORTB = 0b00100100;
	movlw	(024h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	130
;main.c: 130: PORTC = 0b00100011;
	movlw	(023h)
	movwf	(7)	;volatile
	line	131
;main.c: 131: displayState = 2;
	movlw	(02h)
	bsf	fsr,5	;FSR5=1, select bank1
	movwf	(_displayState)^020h
	line	132
;main.c: 132: } else {
	goto	l1729
	
l141:	
	line	133
	
l1725:	
;main.c: 133: PORTB = 0b00010100;
	movlw	(014h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	134
;main.c: 134: PORTC = 0b00001011;
	movlw	(0Bh)
	movwf	(7)	;volatile
	line	135
	
l1727:	
;main.c: 135: displayState = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_displayState)^020h
	goto	l1729
	line	136
	
l142:	
	goto	l1729
	
l140:	
	line	137
	
l1729:	
;main.c: 136: }
;main.c: 137: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	goto	l1621
	line	138
	
l138:	
	line	139
;main.c: 138: }
;main.c: 139: break;
	goto	l1621
	line	140
;main.c: 140: case 5:
	
l143:	
	line	141
	
l1731:	
;main.c: 141: if(softwareTimer >= 8) {
	movlw	(08h)
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2721
	goto	u2720
u2721:
	goto	l1621
u2720:
	line	142
	
l1733:	
;main.c: 142: if(displayState == 0) {
	movf	(_displayState)^020h,f
	skipz
	goto	u2731
	goto	u2730
u2731:
	goto	l1739
u2730:
	line	143
	
l1735:	
;main.c: 143: PORTB = 0b00110100;
	movlw	(034h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	144
;main.c: 144: PORTC = 0b00111111;
	movlw	(03Fh)
	movwf	(7)	;volatile
	line	145
	
l1737:	
;main.c: 145: displayState = 1;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_displayState)^020h
	bsf	status,0
	rlf	(_displayState)^020h,f
	line	146
;main.c: 146: } else {
	goto	l1743
	
l145:	
	line	147
	
l1739:	
;main.c: 147: PORTB = 0b00000100;
	movlw	(04h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	148
;main.c: 148: PORTC = 0b00000011;
	movlw	(03h)
	movwf	(7)	;volatile
	line	149
	
l1741:	
;main.c: 149: displayState = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_displayState)^020h
	goto	l1743
	line	150
	
l146:	
	line	151
	
l1743:	
;main.c: 150: }
;main.c: 151: softwareTimer = 0;
	clrf	(_softwareTimer)^020h
	goto	l1621
	line	152
	
l144:	
	line	153
;main.c: 152: }
;main.c: 153: break;
	goto	l1621
	line	154
;main.c: 154: case 6:
	
l147:	
	line	155
	
l1745:	
;main.c: 155: if(softwareTimer >= 2) {
	movlw	(02h)
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2741
	goto	u2740
u2741:
	goto	l1621
u2740:
	line	156
	
l1747:	
;main.c: 156: randomNum = rand();
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

	line	157
	
l1749:	
;main.c: 157: PORTB = (unsigned char) (((randomNum & 0xFF00) >> 8) & 0b00110100);
	movf	(_randomNum+1)^020h,w
	movwf	btemp+7
	movf	(_randomNum)^020h,w
	movwf	btemp+6
	movf	1+wtemp3,w
	andlw	034h
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	158
	
l1751:	
;main.c: 158: PORTC = (unsigned char) ((randomNum & 0x00FF) & 0b00111111);
	bsf	fsr,5	;FSR5=1, select bank1
	movf	(_randomNum)^020h,w
	andlw	03Fh
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(7)	;volatile
	line	159
	
l1753:	
;main.c: 159: softwareTimer = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_softwareTimer)^020h
	goto	l1621
	line	160
	
l148:	
	line	161
;main.c: 160: }
;main.c: 161: break;
	goto	l1621
	line	162
;main.c: 162: case 7:
	
l149:	
	line	163
	
l1755:	
;main.c: 163: if(softwareTimer >= 2) {
	movlw	(02h)
	subwf	(_softwareTimer)^020h,w
	skipc
	goto	u2751
	goto	u2750
u2751:
	goto	l1621
u2750:
	line	164
	
l1757:	
;main.c: 164: randomNum = rand();
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

	line	165
	
l1759:	
;main.c: 165: scratchPad = (unsigned char) (((randomNum & 0xFF00) >> 8) & 0b00110100);
	movf	(_randomNum+1)^020h,w
	movwf	btemp+7
	movf	(_randomNum)^020h,w
	movwf	btemp+6
	movf	1+wtemp3,w
	andlw	034h
	movwf	(_scratchPad)^020h
	line	166
	
l1761:	
;main.c: 166: scratchPad |= 0b00000100;
	bsf	(_scratchPad)^020h+(2/8),(2)&7
	line	167
	
l1763:	
;main.c: 167: PORTB = scratchPad;
	movf	(_scratchPad)^020h,w
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(6)	;volatile
	line	168
	
l1765:	
;main.c: 168: scratchPad = (unsigned char) ((randomNum & 0x00FF) & 0b00111111);
	bsf	fsr,5	;FSR5=1, select bank1
	movf	(_randomNum)^020h,w
	andlw	03Fh
	movwf	(_scratchPad)^020h
	line	169
	
l1767:	
;main.c: 169: scratchPad |= 0b00000011;
	movlw	(03h)
	movwf	btemp+7
	movf	btemp+7,w
	iorwf	(_scratchPad)^020h,f
	line	170
	
l1769:	
;main.c: 170: PORTC = scratchPad;
	movf	(_scratchPad)^020h,w
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(7)	;volatile
	line	171
	
l1771:	
;main.c: 171: softwareTimer = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	clrf	(_softwareTimer)^020h
	goto	l1621
	line	172
	
l150:	
	line	173
;main.c: 172: }
;main.c: 173: break;
	goto	l1621
	line	174
;main.c: 174: case 8:
	
l151:	
	line	175
	
l1773:	
;main.c: 175: PORTB = 0;
	bcf	fsr,5	;FSR5=0, select bank0
	clrf	(6)	;volatile
	line	176
;main.c: 176: PORTC = 0;
	clrf	(7)	;volatile
	line	179
	
l1775:	
# 179 "C:\projects-hg\christmasornament2011\code\main.c"
     SLEEP ;#
psect	maintext
	line	181
	
l1777:	
# 181 "C:\projects-hg\christmasornament2011\code\main.c"
# 180 ;#
psect	maintext
	line	183
	
l1779:	
;main.c: 183: currentMode = 0;
	bsf	fsr,5	;FSR5=1, select bank1
	bcf	fsr,6	;FSR6=0, select bank1
	clrf	(_currentMode)^020h
	line	184
;main.c: 184: break;
	goto	l1621
	line	185
;main.c: 185: default:
	
l152:	
	line	186
	
l1781:	
;main.c: 186: currentMode = 0;
	clrf	(_currentMode)^020h
	line	187
;main.c: 187: break;
	goto	l1621
	line	188
	
l1783:	
;main.c: 188: }
	goto	l1621
	line	68
	
l119:	
	
l1785:	
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
	goto	l1659
	xorlw	1^0	; case 1
	skipnz
	goto	l1665
	xorlw	2^1	; case 2
	skipnz
	goto	l1679
	xorlw	3^2	; case 3
	skipnz
	goto	l1693
	xorlw	4^3	; case 4
	skipnz
	goto	l1713
	xorlw	5^4	; case 5
	skipnz
	goto	l1731
	xorlw	6^5	; case 6
	skipnz
	goto	l1745
	xorlw	7^6	; case 7
	skipnz
	goto	l1755
	xorlw	8^7	; case 8
	skipnz
	goto	l1773
	goto	l1781
	opt asmopt_on

	line	188
	
l122:	
	goto	l1621
	line	190
	
l153:	
	line	25
	goto	l1621
	
l154:	
	line	191
	
l155:	
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
	
l1607:	
	bsf	fsr,5	;FSR5=1, select bank1
	bcf	fsr,6	;FSR6=0, select bank1
	movf	(_randf)^020h,f
	skipz
	goto	u2501
	goto	u2500
u2501:
	goto	l1611
u2500:
	line	16
	
l1609:	
	movlw	low(01h)
	bcf	fsr,5	;FSR5=0, select bank0
	movwf	(?_srand)
	movlw	high(01h)
	movwf	((?_srand))+1
	fcall	entry__srand
	goto	l1611
	
l165:	
	line	17
	
l1611:	
	bsf	fsr,5	;FSR5=1, select bank1
	bcf	fsr,6	;FSR6=0, select bank1
	movf	(_randx)^020h,w
	movwf	ltemp1
	movf	(_randx+1)^020h,w
	movwf	(ltemp1+1)
	movf	(_randx+2)^020h,w
	movwf	(ltemp1+2)
	movf	(_randx+3)^020h,w
	movwf	(ltemp1+3)
	movf	3+ltemp1,w
	bcf	fsr,5	;FSR5=0, select bank0
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
	bsf	fsr,5	;FSR5=1, select bank1
	movwf	(_randx+3)^020h
	movf	2+ltemp1,w
	movwf	(_randx+2)^020h
	movf	1+ltemp1,w
	movwf	(_randx+1)^020h
	movf	0+ltemp1,w
	movwf	(_randx)^020h

	movf	((_randx)^020h),w
	movwf	ltemp0
	movf	((_randx+1)^020h),w
	movwf	(ltemp0+1)
	movf	((_randx+2)^020h),w
	movwf	(ltemp0+2)
	movf	((_randx+3)^020h),w
	movwf	(ltemp0+3)
	movlw	010h
	bcf	fsr,5	;FSR5=0, select bank0
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
	goto	l166
	
l1613:	
	line	18
	
l166:	
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
	
l1591:	
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

	goto	l1593
	line	6
	
l250:	
	line	7
	
l1593:	
	btfss	(___lmul@multiplier),(0)&7
	goto	u2461
	goto	u2460
u2461:
	goto	l1597
u2460:
	line	8
	
l1595:	
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
	goto	l1597
	
l251:	
	line	9
	
l1597:	
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
	
l1599:	
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
	
l1601:	
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
	goto	l1593
u2490:
	goto	l1603
	
l252:	
	line	12
	
l1603:	
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

	goto	l253
	
l1605:	
	line	13
	
l253:	
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
	
l1587:	
	bcf	fsr,5	;FSR5=0, select bank0
	bcf	fsr,6	;FSR6=0, select bank0
	movf	(srand@x),w
	bsf	fsr,5	;FSR5=1, select bank1
	movwf	(_randx)^020h
	bcf	fsr,5	;FSR5=0, select bank0
	movf	(srand@x+1),w
	bsf	fsr,5	;FSR5=1, select bank1
	movwf	((_randx)^020h)+1
	clrf	2+((_randx)^020h)
	clrf	3+((_randx)^020h)
	line	10
	
l1589:	
	clrf	(_randf)^020h
	bsf	status,0
	rlf	(_randf)^020h,f
	line	11
	
l162:	
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
