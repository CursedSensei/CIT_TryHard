#include <stdio.h>

void createArray(int la[], int size)
{
   	int i, j, item;
	for(i = 0; i < size; i++){
    printf("Enter item: ");
	scanf("%d", &item);
    for(j = 0; j < i; j++){
          if(la[j] == item){
          printf("inputted integer already exists, try another no.: ");
          scanf("%d", &item);
          j = 0;
          }
    }
    la[i] = item;
	}
}

void printArray(int la[],int size)
{
	int i;
    for(i = 0; i < size; i++){
    	printf("%d ", la[i]);
	}
	printf("\n");
}

int inserAtPos(int la[], int size, int item, int k)
{
    int i, j;
    if(la[0] == 0){
    printf("Array is empty, create an array first\n");
    return 0;
    }
    printf("Enter items: ");
    scanf("%d", &item);
    printf("Enter position: ");
    scanf("%d", &k);
	for(i = 0; i < size; i++){
          if(la[i] == item){
          printf("Data item you wish to add already exists in the array...try another!: ");
          scanf("%d", &item);
          i = 0;
          }
	}
	for(j = size-1; j >= k; j--){
          la[j+1] = la[j];
    }
    la[k] = item;
	return size + 1;
}

void insertFront(int la[], int *size, int item)
{
  	int i, j;
  	if(la[0] == 0){
    printf("Array is empty, create an array first\n");
    }
    printf("Enter item: ");
    scanf("%d", &item);
	for(i = 0; i < *size; i++){
          if(la[i] == item){
          printf("Data item you wish to add already exists in the array...try another!: ");
          scanf("%d", &item);
          i = 0;
          }
	}
	for(j = *size-1; j >= 0; j--){
          la[j+1] = la[j];
    }
    la[0] = item;
	*size += 1;
}

void removeAtPos(int la[], int *size, int index)
{
    int j;
    printf("Enter position: ");
    scanf("%d", &index);
	for(j = index; j < *size; j++){
          la[j] = la[j+1];
    }
    *size -= 1;
}

int removeItem(int la[], int size, int item){
	int i, j;
    printf("Enter item: ");
    scanf("%d", &item);
	for(i = 0; i < size; i++){
          if(la[i] == item){
          for(j = i; j < size; j++){
          la[j] = la[j+1];
          }
          return size - 1;
          }
	}
	printf("Item not found\n");
	return -1;
}

int removeFront(int la[],int size){
    int j;
	for(j = 0; j < size; j++){
          la[j] = la[j+1];
    }
    printf("Item removed!\n");
	return size -= 1;
}

int locateIndex(int la[], int size, int item){
    int i;
    printf("Search item: ");
    scanf("%d", &item);
    for(i = 0; i < size; i++){
          if(la[i] == item){
          return i;
          }
    }
    return -1;
}

int locateItem(int la[],int size, int item){
    int i;
    printf("Search item: ");
    scanf("%d", &item);
    for(i = 0; i < size; i++){
          if(la[i] == item){
          return 1;
          }
    }
    return 0;
}

void sortAscending(int la[], int size){
     int i, j, temp;
     for(i = 0; i < size; i++){
           for(j = i+1; j <= size; j++){
                 if(la[i] >= la[j]){
                 temp = la[j];
                 la[j] = la[i];
                 la[i] = temp;
                 }
           }
     }
     printf("ARRAY list in ASCENDING order: ");
}

void sortDescending(int la[],int size){
     int i, j, temp;
     for(i = 0; i < size; i++){
           for(j = i+1; j < size; j++){
                 if(la[i] <= la[j]){
                 temp = la[j];
                 la[j] = la[i];
                 la[i] = temp;
                 }
           }
     }
     printf("ARRAY list in DESCENDING order: ");
}
