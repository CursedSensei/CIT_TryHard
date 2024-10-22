#include <iostream>
#include "list.h"
using namespace std;

class ArrayList : public List {
    public:
    int first;
    int last;
    int size;
    int array[10];
    ArrayList() {
        for (int i = 0; i < 10; i++) {
            array[i] = 0;
        }
        size = 0;
        first = 0;
        last = 0;
    }

    int capacity() {
        return 10;
    }

    void add(int num) {
    	addLast(num);
	}

    // TODO implement this method
    void addFirst(int num) {
        if (size < 10) {
            if (first == 0) first = 10;
            array[--first] = num;
			size++;
        } else {
            cout << "PUNO NA" << endl;
        }
    }

    // already completed
    void addLast(int num) {
        if (size < 10) {
            array[last++] = num;
            if (last == 10) {
            	last = 0;
			}
			size++;
        } else {
            cout << "PUNO NA" << endl;
        }
    }

    // TODO implement this method
    int removeFirst() {
        if (!size) return 0;
        
        int ret = array[first++];
        if (first == 10) first = 0;
        size--;
        
        return ret;
	}

    // TODO implement this method
    int removeLast() {
		if (!size) return 0;
		
		if (--last == -1) last = 9;
		size--;
		return array[last];
	}

    // Warning: Do not modify the codes below this point.
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
                // Step 4: Return
                return i+1;
            }
        }
        return -1;
    }

    int get(int pos) {
        return array[pos-1];
    }

    int _size() {
    	return size;
	}

    void print() {
        int i;
        if (size == 10) {
            for (i = 0; i < 10; i++) {
                cout << array[i] << " ";
            }
        } else if (first <= last) {
            for (i=0; i < first; i++) {
                cout << "? ";
            }
            for (; i < last; i++) {
                cout << array[i] << " ";
            }
            for (; i < 10; i++) {
                cout << "? ";
            }
        } else {
            for (i = 0; i < last; i++) {
                cout << array[i] << " ";
            }
            for (; i < first; i++) {
                cout << "? ";
            }
            for (; i < 10; i++) {
                cout << array[i] << " ";
            }
        }
        cout << endl;
        cout << "First Index: " << first << endl;
        cout << "Last Index: " << last << endl;
    }
};