#include <stdio.h>
#include <stdlib.h>
#include "dynArray.h"

int main() {
	int *LA = (int *)malloc(0), size = 0, count = 0, input;
	
	do {
		menu();
		scanf("%d", &input);
		switch (input) {
			case 1:
				printf("\nSize of the array: ");
				scanf("%d", &size);
				LA = (int *)realloc(LA, size * sizeof(int));
				createArray(LA, size);
				count = size;
				break;
			case 2:
				printArray(LA, count);
				break;
			case 3:
				
				break;
			case 6:
				LA = resize(LA, &size);
				printf("main: %x", LA);
				break;
			default:
				printf("\nInvalid Input\n");
		}
		
		printf("\n");
	} while (input != 8);
	
	free(LA);
	return 0;
}
