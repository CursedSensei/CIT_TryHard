#include "gotoxy.h"
#include <stdio.h>

void drawSBox(int x1, int y1, int x2, int y2) {
	int j, i;
	
	system("cls");
	printf("%c", 218);
	for (j = x2 - x1 - 2; j != 0; j--) {
		printf("%c", 196);
	}
	printf("%c\n", 191);
	for (i = y2 - y1 - 2; i != 0; i--) {
		printf("%c", 179);
		for (j = x2 - x1 - 2; j != 0; j--) {
			printf("%c", ' ');
		}
		printf("%c\n", 179);
	}
	printf("%c", 192);
	for (j = x2 - x1 - 2; j != 0; j--) {
		printf("%c", 196);
	}
	printf("%c\n", 217);
}

void menu() {
	gotoxy(10, 1);
	printf("Conversion");
	
	gotoxy(2, 3);
	printf("[a] Time");
	gotoxy(2, 4);
	printf("[b] Coin");
	gotoxy(2, 5);
	printf("[c] Display");
	gotoxy(2, 6);
	printf("\t[1] Time");
	gotoxy(2, 7);
	printf("\t[2] Coin");
	gotoxy(2, 8);
	printf("[d] Exit");
	
	gotoxy(2, 10);
	printf("Enter your choice: ");
}
