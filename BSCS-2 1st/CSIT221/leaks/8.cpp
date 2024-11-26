#include <iostream>
#include <cstdlib>
#include <cmath>
#include "minheap.h"
using namespace std;

class ArrayMinHeap : public MinHeap {
    int* array;
    int size;
    int capacity = 5;

	int left(int n) {
        return n * 2 + 1;
	}

	int right(int n) {
        return n * 2 + 2;
	}
	
	int parent(int n) {
	    return (n - 1) / 2;
	}

    public:
    ArrayMinHeap() {
    	array = (int *)malloc(capacity * sizeof(int));
    	size = 0;
	}

    // TODO insert the num into the heap
	void insert(int num) {
        if (size == capacity) {
            capacity = ceil(1.5 * capacity);
            array = (int *)realloc(array, capacity * sizeof(int));
        }
        
        int idx = size++;
        array[idx] = num;
        
        while (idx != 0) {
            if (array[parent(idx)] > num) {
                array[idx] = array[parent(idx)];
                array[parent(idx)] = num;
                idx = parent(idx);
            } else {
                break;
            }
        }
	}

    // TODO remove the minimum value, -1 if empty
	int removeMin() {
		if (!size) return -1;
		
		int idx = 0;
		int ret = array[idx];
		array[idx] = array[--size];
		int num = array[idx];
		
		while (idx < size - 1) {
		    int lChild = left(idx);
		    int rChild = right(idx);
		    if (rChild < size && array[lChild] > array[rChild] && array[rChild] < num) {
	            array[idx] = array[rChild];
	            array[rChild] = num;
	            idx = rChild;
		    } else if (lChild < size && array[lChild] < num) {
		        array[idx] = array[lChild];
	            array[lChild] = num;
	            idx = lChild;
		    } else {
		        break;
		    }
		    
		}
		
		if (size < ceil(3.0 / 4 * capacity)) {
		    capacity = ceil(0.8 * capacity);
		    capacity = max(capacity, 5);
            array = (int *)realloc(array, capacity * sizeof(int));
		}
		
		return ret;
	}

    // DO NOT modify the code below
	void print() {
		if (size == 0) {
			cout << "EMPTY" << endl;
			return;
		}
			cout << "Size: " << size << "/" << capacity << endl;
			cout << "TREE: " << endl;
			print_tree("", 0, false);

		cout << "ARRAY: ";
		for (int i = 0; i < size; i++) {
			cout << array[i] << " ";
		}
		cout << endl;
	}

	void print_tree(string prefix, int n, bool isLeft) {
		cout << prefix;
        cout << (isLeft ? "+--L: " : "+--R: " );
        cout << array[n] << endl;
		if (left(n) < size) {
			print_tree(prefix + "|   ", left(n), true);
		}
		if (right(n) < size) {
			print_tree(prefix + "|   ", right(n), false);
		}
	}
};