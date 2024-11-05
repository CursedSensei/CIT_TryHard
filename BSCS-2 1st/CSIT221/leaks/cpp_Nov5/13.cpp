#include <iostream>
#include <string>
#include "arraystack.h"
using namespace std;

int main() {
	Stack* stack = new ArrayStack();
	string a, b, input;
	
	do {
	    cout << "Enter: ";
	    cin >> input;
	    if(isalnum(input[0]) && input != "x") {
	       stack->push(input);
	    } else if (input != "x") {
	        a = stack->pop();
	        b = stack->pop();
	        
	        stack->push(input + " " + b + " " + a);
	    }
	} while (input != "x");
	
	cout << "Prefix: " << stack->pop() << endl;

    return 0;
}