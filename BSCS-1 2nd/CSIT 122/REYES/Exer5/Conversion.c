#include <stdio.h>

void convertTime(int time, int* hours, int* mins, int* sec) {
	*hours = time / 3600;
	*mins = (time % 3600) / 60;
	*sec = (time % 3600) % 60;
}

void displayTime(int time, int* hours, int* mins, int* sec) {
	printf("\n%d seconds is equal to\n%d hour(s), %d minute(s) and %d second(s).\n\n", time, *hours, *mins, *sec);
	system("pause");
}

void computeCoin(int coinValue, int* quarter, int* dime, int* penny) {
	if (coinValue < 0 && coinValue >= 100) return;

	*quarter = coinValue / 25;
	*dime = (coinValue % 25) / 10;
	*penny = (coinValue % 25) % 10;
}
void displayCoin(int coinValue, int* quarter, int* dime, int* penny) {
	printf("\n%d cents can be given as\n%d quarter(s) %d dime(s) and %d penny (pennies)\n\n", coinValue, *quarter, *dime, *penny);
	system("pause");
}
