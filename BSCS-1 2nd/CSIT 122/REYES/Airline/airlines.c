#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void initSeats(int *seats, int size) {
	int i;
	for (i = 0; i < size; i++) {
		*(seats++) = 0; 
	}
}

void displaySeats(int *seats, int size) {
	printf("First Class Section:");
	int i;
	
	size /= 2;
	
	for (i = 0; i < size; i++) {
		printf(" [%d]", *(seats++));
	}
	printf("\n");
	printf("Economy Section:    ");
	for (i = 0; i < size; i++) {
		printf(" [%d]", *(seats++));
	}
	printf("\n\n");
}

int assignFirstClass(int *seats, int size) {
	int i;
	for (i = 0; i < size; i++) {
		if (*(seats + i) == 0) {
			*(seats + i) = 1;
			return i + 1;
		}
	}
	return -1;
}

int assignEconomy(int *seats, int size) {
	int i;
	
	seats += 5;
	for (i = 0; i < size; i++) {
		if (*(seats + i) == 0) {
			*(seats + i) = 1;
			return i + 6;
		}
	}
	return -1;
}

void boardRow(char *out, int x) {
	printf("%c", 179);
	printf(" %s", out);
	
	int i;
	for (i = x - 3 - strlen((const char *)out); i; i--) {
		printf(" ");
	}
	printf("%c\n", 179);
}

void boardPass(int seat) {
	int i, x = 30;
	
	printf("%c", 218);
	for (i = x - 2; i; i--) {
		printf("%c", 196);
	}
	printf("%c\n", 191);
	
	
	char out[30];
	boardRow("", x);
	boardRow("Boarding Pass", x);
	if (seat <= 5) {
		strcpy(out, "First Class Section");
	} else {
		strcpy(out, "Economy Section");
	}
	boardRow(out, x);
	snprintf(out, 30, "Seat #%d", seat);
	boardRow(out, x);
	boardRow("", x);
	
	printf("%c", 192);
	for (i = x - 2; i; i--) {
		printf("%c", 196);
	}
	printf("%c\n\n", 217);
}

int assignSeat(int *st, int seatType) {
	int seat;
	if (seatType == 1) {
		seat = assignFirstClass(st, 5);
	} else if (seatType == 2) {
		seat = assignEconomy(st, 5);
	}
	if (seat == -1) {
		return 0;
	}
	
	boardPass(seat);
	return seat;
}

void Exit(void) {
	printf("Next flight leaves in 3 hours.\n\n");
	system("pause");
}
