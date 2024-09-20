#include "list.h"
#include <iostream>

using namespace std;

class ArrayList : public List {
	public:
		int arr[5];
		int size = 0;
		
		void add (int num) {
			cout << "Add " << num << endl;
			arr[size++] = num;
		}
		
		void print() {
			cout << "Size: " << size << endl;
			
			for (int i = 0; i < size; i++) {
				cout << arr[i] << " ";
			}
			
			cout << endl;
		}
		
		int get(int pos) {
			return arr[pos - 1];
		};
		
		int remove(int val) {
			for (int i = 0; i < size; i++) {
				if (arr[i] == val) {
					for (int j = i + 1; j < size; j++) {
						arr[j - 1] = arr[j];
					}
					size--;
					
					return i + 1;
				}
			}
			
			return -1;
		};
};
