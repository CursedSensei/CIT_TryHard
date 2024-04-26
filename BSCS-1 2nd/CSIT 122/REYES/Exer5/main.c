#include "Conversion.h"
#include "gotoxy.h"
#include <stdio.h>

int main() {
	char input;
	int time = 0, hours = 0, mins = 0, sec = 0, coinValue = 0, quarter = 0, dime = 0, penny = 0;
	
	do {
		drawSBox(0, 0, 30, 20);
		menu();
		
		scanf(" %c", &input);
		
		gotoxy(20, 20);
		
		switch (input) {
			case 'a':
				{
					printf("\n\nInput time in seconds to convert: ");
					scanf("%d", &time);
					convertTime(time, &hours, &mins, &sec);
				}
				break;
			case 'b':
				{
					printf("\n\nInput coin value to convert: ");
					scanf("%d", &coinValue);
					computeCoin(coinValue, &quarter, &dime, &penny);
				}
				break;
			case 'c':
				{
					gotoxy(2, 11);
					printf("Input what to display: ");
					int type;
					
					scanf("%d", &type);
					
					gotoxy(20, 20);
					if (type == 1) {
						displayTime(time, &hours, &mins, &sec);
					} else if (type == 2) {
						displayCoin(coinValue, &quarter, &dime, &penny);
					}
				}
				break;
		}
	} while (input != 'd');
	
	return 0;
}
