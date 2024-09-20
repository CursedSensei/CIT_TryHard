#include <iostream>

int main() {
	int size = 5;
	int* dynamicArray = new int[size];

	// Access and modify elements in the dynamic array
	dynamicArray[0] = 10;
	dynamicArray[1] = 20;
	dynamicArray[2] = 30;
	dynamicArray[3] = 40;
	dynamicArray[4] = 50;

	// Resize the dynamic array
	size = 10;
	int* resizedArray = new int[size];

	// Copy the existing elements to the resized array
	for (int i = 0; i < size; i++) {
		resizedArray[i] = dynamicArray[i];
	}

	// Delete the original dynamic array
	delete[] dynamicArray;

	// Point the dynamicArray pointer to the resized array
	dynamicArray = resizedArray;

	// Access and modify additional elements
	dynamicArray[5] = 60;
	dynamicArray[6] = 70;
	dynamicArray[7] = 80;
	dynamicArray[8] = 90;
	dynamicArray[9] = 100;

	// Print the elements
	for (int i = 0; i < size; i++) {
		std::cout << dynamicArray[i] << " ";
	}
	std::cout << std::endl;

	// Delete the resized dynamic array
	delete[] dynamicArray;

	return 0;
}
