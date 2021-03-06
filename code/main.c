#define _XTAL_FREQ 4000000
#include <htc.h>
#include <stdlib.h>

__CONFIG(OSC_IntRC_RB4EN & WDT_OFF & CP_OFF & MCLRE_ON);

unsigned char currentMode = 0;
unsigned int softwareTimer = 0;
unsigned char displayState = 0;
unsigned char scratchPad = 0;
unsigned char switchState = 0;
unsigned char inhibitModeChange = 1;
unsigned char newPortB = 0;
unsigned char newPortC = 0;
int randomNum = 0;

void main(void) {
	//initialize timer and wakeup
	OPTION = 0b01000111;
	//TMR0 = 0;
	TRISC = 0x00;
	TRISB = 0x01;
	PORTC = 0x00;
	PORTB = 0x00;

	//loop forever
	while(1) {
		//software timer
		//if(TMR0 == 0) {
			PORTB = newPortB;
			PORTC = newPortC;
			__delay_us(50);
			PORTB = 0;
			PORTC = 0;
			__delay_us(50);
			__delay_us(250);
			__delay_us(250);
			softwareTimer++;
			//TMR0 = 1;
	
			//check switch - if on, increment mode
			if(switchState == 0) {
				//switch armed - if input is low, we arm for a check when softwareTimer increments next
				//if it's still low then, we wait for it to go high again, and then move to the next mode
				if(!(PORTB & 0x01)) {
					switchState = 1;
				} else {
					switchState = 0;
				}
			} else if(switchState == 1) {
				//if it's still low, go to state 3, where we wait for it to go high again
				if(!(PORTB & 0x01)) {
					switchState = 2;
				} else {
					switchState = 1;
				}
			} else if(switchState == 2) {
				// we now wait until the switch goes high, then we increment currentMode, reset displayState and softwareTimer
				if(PORTB & 0x01) {
					if(inhibitModeChange) {
						inhibitModeChange = 0;
					} else {
						currentMode++;
						if(currentMode > 8) currentMode = 0;
						displayState = 0;
						softwareTimer = 0;
					}
					switchState = 0;
				} else {
					switchState = 2;
				}
			} else {
				switchState = 0;
			}
	
			//process based on mode
			switch(currentMode) {
				case 0:
					if(softwareTimer >= 8) {
						newPortB = 0b00110100;
						newPortC = 0b00111111;
						softwareTimer = 0;
					}
					break;
				case 1:
					if(softwareTimer >= 800) {
						if(displayState == 0) {
							newPortB = 0b00110100;
							newPortC = 0b00111111;
							displayState = 1;
						} else {
							newPortB = 0x00;
							newPortC = 0x00;
							displayState = 0;
						}
						softwareTimer = 0;
					}
					break;
				case 2:
					if(softwareTimer >= 800) {
						if(displayState == 0) {
							newPortB = 0b00000100;
							newPortC = 0b00101110;
							displayState = 1;
						} else {
							newPortB = 0b00110000;
							newPortC = 0b00010001;
							displayState = 0;
						}
						softwareTimer = 0;
					}
					break;
				case 3:
					if(softwareTimer >= 400) {
						if(displayState == 0) {
							newPortB = 0b00000000;
							newPortC = 0b00010110;
							displayState = 1;
						} else if(displayState == 1) {
							newPortB = 0b00100000;
							newPortC = 0b00100001;
							displayState = 2;
						} else {
							newPortB = 0b00010100;
							newPortC = 0b00001000;
							displayState = 0;
						}
						softwareTimer = 0;
					}
					break;
				case 4:
					if(softwareTimer >= 400) {
						if(displayState == 0) {
							newPortB = 0b00000100;
							newPortC = 0b00010111;
							displayState = 1;
						} else if(displayState == 1) {
							newPortB = 0b00100100;
							newPortC = 0b00100011;
							displayState = 2;
						} else {
							newPortB = 0b00010100;
							newPortC = 0b00001011;
							displayState = 0;
						}
						softwareTimer = 0;
					}
					break;
				case 5:
					if(softwareTimer >= 800) {
						if(displayState == 0) {
							newPortB = 0b00110100;
							newPortC = 0b00111111;
							displayState = 1;
						} else {
							newPortB = 0b00000100;
							newPortC = 0b00000011;
							displayState = 0;
						}
						softwareTimer = 0;
					}
					break;
				case 6:
					if(softwareTimer >= 200) {
						randomNum = rand();
						newPortB = (unsigned char) (((randomNum & 0xFF00) >> 8) & 0b00110100);
						newPortC = (unsigned char) ((randomNum & 0x00FF) & 0b00111111);
						softwareTimer = 0;
					}
					break;
				case 7:
					if(softwareTimer >= 200) {
						randomNum = rand();
						scratchPad = (unsigned char) (((randomNum & 0xFF00) >> 8) & 0b00110100);
						scratchPad |= 0b00000100;
						newPortB = scratchPad;
						scratchPad = (unsigned char) ((randomNum & 0x00FF) & 0b00111111);
						scratchPad |= 0b00000011;
						newPortC = scratchPad;
						softwareTimer = 0;
					}
					break;
				case 8:
					PORTB = 0;
					PORTC = 0;
					//sleep
					#asm
					SLEEP
					#endasm
					currentMode = 0;
					break;
				default:
					currentMode = 0;
					break;
			}
		//}
	}
}