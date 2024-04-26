#include <stdio.h>
#include "airlines.h"

int main() {
	printf("Airline Reservation System\n\n");
	int seats[10], size = 10, input;
	
	initSeats(seats, size);
	
	while (size) {
		displaySeats(seats, size);
		
		printf("Please type 1 for \"first class\"\nPlease type 2 for \"economy\" : ");
		scanf("%d", &input);
		printf("\n");
		switch (input) {
			case FirstClass:
				input = assignSeat(seats, FirstClass);
				if (input == 0) {
					printf("First Class section is full. Would you want to be placed on Economy section instead? (1 = Yes | 2 = No) : ");
					scanf("%d", &input);
					printf("\n");
					if (input == 1) {
						input = assignSeat(seats, Economy);
						if (input == 0) {
							Exit();
							size = 0;
						}
					} else if (input == 2) {
						Exit();
						size = 0;
					} else {
						printf("Incorrect input\n\n");
					}
				}
				break;	
			case Economy:
				input = assignSeat(seats, Economy);
				if (input == 0) {
					Exit();
					size = 0;
					continue;
				}
				break;
			default:
				printf("Incorrect input\n\n");
		}
	}
	
	return 0;
}
