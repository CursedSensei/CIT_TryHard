#include <stdio.h>
#include <string.h>
#include <ctype.h>

void boxRow(char *out, int x) {
	printf("%c", 179);
	printf(" %s", out);
	
	int i;
	for (i = x - 3 - strlen((const char *)out); i; i--) {
		printf(" ");
	}
	printf("%c\n", 179);
}

void boxPrint() {
	int i, x = 30;
	
	printf("%c", 218);
	for (i = x - 2; i; i--) {
		printf("%c", 196);
	}
	printf("%c\n", 191);
	
	boxRow("       Robby Robot", x);
	boxRow("", x);
	boxRow("[a] Origin", x);
	boxRow("[b] Location", x);
	boxRow("[c] Move", x);
	boxRow("[d] Exit", x);
	
	printf("%c", 192);
	for (i = x - 2; i; i--) {
		printf("%c", 196);
	}
	printf("%c\n\n", 217);
	
	printf("Enter your choice: ");
}


char printCommand(void) {
	char input, final;
	boxPrint();
	
	do {
		scanf("%c", &final);
	} while (final == '\n');
	
	while (input != '\n') {
		scanf("%c", &input);
	}
	
	return tolower(final);
}

void initialize(int *x,int *y) {
	*x = 0;
	*y = 0;
}
void printLocation(int x,int y) {
	printf("\nLocation = (%d, %d)\n\n", x, y);
}
void move(int *x, int *y) {
	int input;
	
	printf("Enter 6-East, 4-West, 8-North, 2-South: ");
	
	scanf("%d", &input);
	
	switch (input) {
		case 6:
			printf("\nEnter how many spaces: ");
			scanf("%d", &input);
			*x += input;
			break;
		case 4:
			printf("\nEnter how many spaces: ");
			scanf("%d", &input);
			*x -= input;
			break;
		case 8:
			printf("\nEnter how many spaces: ");
			scanf("%d", &input);
			*y += input;
			break;
		case 2:
			printf("\nEnter how many spaces: ");
			scanf("%d", &input);
			*y -= input;
			break;
	}
	printf("\n");
}
void Exit(void) {
	printf("Exiting Program!!!\n");
}
