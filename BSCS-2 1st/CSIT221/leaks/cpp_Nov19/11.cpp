#include <iostream>
using namespace std;

int main(void) {
	int len;
	cout << "Enter number of elements: ";
	cin >> len;
	
	int arr[len];
	cout << "Enter preorder: ";
	
	for (int i = 0; i < len; i++) {
	    cin >> arr[i];
	}
	
	for (int i = 0; i < len; i++) {
	    bool right = false;
	    for (int j = i + 1; j < len; j++) {
	        if (right) {
	            if (arr[j] < arr[i]) {
	                cout << "INVALID" << endl;
	                return 0;
	            }
	        } else {
	            if (arr[j] > arr[i]) {
	                right = true;
	            }
	        }
	    }
	}
	
	cout << "VALID" << endl;
	
	return 0;
}