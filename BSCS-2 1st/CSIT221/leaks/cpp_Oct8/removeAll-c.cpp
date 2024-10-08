#include <iostream>
#include <cstdlib>
#include <math.h>
#include "list.h"
using namespace std;

class ArrayList : public List {
    int* array;
    int size;
    int capacity = 5;

	void dynamic_add() {
		int new_size = ceil(capacity * 1.5);
		int* new_array = (int*) realloc(array, sizeof(int) * new_size);
		array = new_array;
		capacity = new_size;
	}

    // TODO dynamically reduce the capacity
	void dynamic_deduce() {
	    capacity -= floor(0.2 * capacity);
	    
	    if (capacity < 5) capacity = 5;
	
        array = (int *)realloc(array, sizeof(int) * capacity);
	}

    public:
    ArrayList() {
    	array = (int*) calloc( capacity, sizeof(int) * 5);
        size = 0;
    }

    void add(int num) {
    	if (size == capacity) {
        	dynamic_add();
		}
        array[size++] = num;
    }

    int remove(int num) {
        // Step 1: FIND the num
        for (int i = 0; i < size; i++) {
            if (array[i] == num) {
                // Step 2: MOVE the elements to left
                for (int j = i; j < size-1; j++) {
                    array[j] = array[j+1];
                }
                // Step 3: Set the size
                array[size-1] = 0;
                size = size-1;
                // Step 4: Check to reduce capacity
                if (size <= 0.67 * capacity) {
                	dynamic_deduce();
				}
                // Step 5: Return
                return i+1;
            }
        }
        return -1;
    }

    int get(int pos) {
        return array[pos-1];
    }

    // TODO add method removeAll here
    int removeAll(int num) {
        int ret = 0;
        
        for (int i = size - 1; i >= 0; i--) {
            if (array[i] == num) {
                for (int j = i + 1; j < size; j++) {
                    array[j - 1] = array[j];
                }
                size--;
                ret++;
            }
        }
        
        if (size <= 3.0 * capacity / 4) {
        	dynamic_deduce();
		}
        
        return ret;
    }

    void print() {
        int i;
        for (i = 0; i < size; i++) {
            cout << array[i] << " ";
        }
        for (; i < capacity; i++) {
            cout << "? ";
        }
        cout << endl;
    }
};