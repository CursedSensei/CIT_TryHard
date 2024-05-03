#include <stdio.h>
#include <stdlib.h>

void createArray(int* LA, int size) {
	int i = 0;
	while (size--) {
		printf("Input Element [%d]: ", i);
		scanf("%d", LA + i++);
	}
}

void printArray(int* LA,int size) {
	int i = 0;
	while (size--) {
		printf("Element [%d]: %d\n", i, *(LA + i));
		i++;
	}
}

int sum(int* LA,int size) {
	int i = 0, sum = 0;
	while (size--) {
		sum += *(LA + i++);
	}
	return sum;
}

int largest(int* LA, int size) {
	int i = 1, large = *LA;
	while (--size) {
		if (*(LA + i) > large) {
			large = *(LA + i);
		}
	}
	return large;
}

int smallest(int* LA, int size) {
	int i = 1, smol = *LA;
	while (--size) {
		if (*(LA + i) < smol) {
			smol = *(LA + i);
		}
	}
	return smol;
}

int *resize(int* LA, int* size) {
	*size *= 2;
	LA = (int *)realloc(LA, *size * sizeof(int));
	return LA;
}

int addElement(int* LA, int* size, int count, int item) {
	*(LA + count++) = item;
	
	return count;
}

void menu() {
	printf("\t~~~~~~~~~~~ ARRAY ~~~~~~~~~~~\n\n");
	printf("\t\t1. CREATEArray\n");
	printf("\t\t2. PRINTArray\n");
	printf("\t\t3. SUM\n");
	printf("\t\t4. LARGEST\n");
	printf("\t\t5. SMALLEST\n");
	printf("\t\t6. RESIZE\n");
	printf("\t\t7. ADD\n");
	printf("\t\t8. EXIT\n\n");
	printf("\tEnter a valid choice[1-8]: ");
}

void Exit() {
	
}
