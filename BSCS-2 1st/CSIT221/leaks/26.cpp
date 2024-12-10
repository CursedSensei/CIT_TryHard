// TODO perform ArrayMaxHeap class // HIDDEN ????
#include <iostream>
#include <cmath>
#include <cstdlib>
using namespace std;

#include "maxheap.hpp"

class ArrayMaxHeap : public MaxHeap {
    int cap = 5;
    int size = 0;
    int * heap = (int*)malloc(cap * sizeof(int));

    void resizeMe() {
        if (cap < 5) cap = 5;
        heap = (int*)realloc(heap, cap * sizeof(int));
    }

    int parent(int pos) {
        return (pos - 1) / 2;
    }
    
    int left(int pos) {
        return (pos * 2) + 1;
    }
    
    int right(int pos) {
        return (pos * 2) + 2;
    }
    
    void swapMe(int pos, int pos2) {
        int temp = heap[pos];
        heap[pos] = heap[pos2];
        heap[pos2] = temp;
    }

public:
	void insert(int num) {
	    if (cap == size) {
	        cap = ceil(1.5 * cap);
	        resizeMe();
	    }
	    
	    heap[size] = num;
	    
	    int idx = size++;
	    while (parent(idx) >= 0) {
	        if (heap[parent(idx)] < heap[idx]) {
	            swapMe(parent(idx), idx);
	            
	            idx = parent(idx);
	        } else break;
	    }
	}

	int removeMax() {
	    if (!size) return -1;
	
	    int idx = 0;
	    int ret = heap[idx];
	    heap[idx] = heap[--size];
	    
	    while (left(idx) < size || right(idx) < size) {
	        if (left(idx) < size && right(idx) < size) {
	            if (heap[idx] < heap[left(idx)] && heap[left(idx)] >= heap[right(idx)]) {
	                swapMe(left(idx), idx);
	                idx = left(idx);
	            } else if (heap[idx] < heap[right(idx)] && heap[left(idx)] <= heap[right(idx)]) {
	                swapMe(right(idx), idx);
	                idx = right(idx);
	            } else {
	                break;
	            }
	        } else if (left(idx) < size && heap[left(idx)] > heap[idx]) {
	            swapMe(left(idx), idx);
	            idx = left(idx);
	        } else if (right(idx) < size && heap[right(idx)] > heap[idx]) {
	            swapMe(right(idx), idx);
	            idx = right(idx);
	        } else {
	            break;
	        }
	    }
	    
	    if (size < ceil(3.0 * cap / 4)) {
	        cap = ceil(.8 * cap);
	        resizeMe();
	    }
	    
	    return ret;
	}
	
	void print() {
	    if (!size) {
			cout << "EMPTY" << endl;
			return;
		}
		cout << "Size: " << size << "/" << cap << endl << "TREE:" << endl;
		print_node("", 0, false);
		cout << "ARRAY: ";
		for (int i = 0; i < size; i++) cout << heap[i] << " ";
		cout << endl;
	}

	void print_node(string prefix, int pos, bool isLeft) {
		cout << prefix;
        cout << (isLeft ? "+--L: " : "+--R: " );
        cout << heap[pos] << endl;
		if (left(pos) < size) {
			print_node(prefix + "|   ", left(pos), true);
		}
		if (right(pos) < size) {
			print_node(prefix + "|   ", right(pos), false);
		}
	}
};