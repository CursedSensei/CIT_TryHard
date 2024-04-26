#include <stdio.h>
#include <windows.h>

void gotoxy(int x,int y)
{
	COORD coord={0,0};
	coord.X=x; 
	coord.Y=y;
	SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),coord);
} 

void drawDBox(int x1,int y1, int x2, int y2){
	int j, i;
	
	for (i = 35; i; i--) {
		printf(" ");
	}
	printf("%c", 218);
	for (j = x2 - x1 - 2; j != 0; j--) {
		printf("%c", 196);
	}
	printf("%c\n", 191);
	for (i = y2 - y1 - 2; i != 0; i--) {
		for (j = 35; j; j--) {
			printf(" ");
		}
		printf("%c", 179);
		for (j = x2 - x1 - 2; j != 0; j--) {
			printf("%c", ' ');
		}
		printf("%c\n", 179);
	}
	for (i = 35; i; i--) {
		printf(" ");
	}
	printf("%c", 192);
	for (j = x2 - x1 - 2; j != 0; j--) {
		printf("%c", 196);
	}
	printf("%c\n", 217);
}

void menu(){
	int choice, size = 13, item, k, prevSize, index, result;
	int la[100];
	
	while(choice != 11){
		system("cls");
		drawDBox(0, 0, 50, 17);
		gotoxy(46, 1);
		printf("~~~~~~ ARRAY OPERATIONS  ~~~~");
		gotoxy(50, 3);
		printf("1.CREATEArray");
		gotoxy(50, 4);
		printf("2.PRINTArray");
		gotoxy(50, 5);
		printf("3.INSERTAtPos");
		gotoxy(50, 6);
		printf("4.INSERTFront");
		gotoxy(50, 7);
		printf("5.REMOVEAtPos");
		gotoxy(50, 8);
		printf("6.REMOVEItem");
		gotoxy(50, 9);
		printf("7.REMOVEFront");
		gotoxy(50, 10);
		printf("8.LOCATEIndx");
		gotoxy(50, 11);
		printf("9.LOCATEItem");
		gotoxy(50, 12);
		printf("10.SORT(Ascending& Descending");
		gotoxy(50, 13);
		printf("11.EXIT");
		gotoxy(50, 14);
		printf("Enter a valid choice[1-11]: ");
		scanf("%d", &choice);
		gotoxy(0, 18);
		switch(choice){
		 	case 1:
		         createArray(la, size);
		         system("pause");
		         break;
		    case 2:
		         printArray(la, size);
		         system("pause");
		         break;
		    case 3:
		         size = inserAtPos(la, size, item, k);
		         system("pause");
		         break;
		    case 4:
		         insertFront(la, &size, item);
		         system("pause");
		         break;
		    case 5:
		         removeAtPos(la, &size, k);
		         system("pause");
		         break;
		    case 6:
		         prevSize = size;
		         size = removeItem(la, size, item);
		         if(size == -1){
		         size = prevSize-1;
		         }
		         system("pause");
		         break;
		    case 7:
		         size = removeFront(la, size);
		         system("pause");
		         break;
		    case 8:
		         index = locateIndex(la, size, item);
		         if(index != -1){
		         printf("Item found at index %d!\n", index);
		         }else{
		         printf("Item not found\n");
		         }
		         system("pause");
		         break;
		    case 9:
		         result = locateItem(la, size, item);
		         if(result == 1){
		         printf("Item found!\n");
		         }else if(result == 0){
		         printf("Item not found\n");
		         }
		         system("pause");
		         break;
		    case 10:
		         sortAscending(la, size);
		         printArray(la, size);
		         sortDescending(la, size);
		         printArray(la, size);
		         sortAscending(la, size); //to reorder array to normal
		         system("pause");
		         break;
		 }
	}
}
