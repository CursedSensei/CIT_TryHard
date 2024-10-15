#include <iostream>
#include <string>
#include "arraystack.h"
using namespace std;

int main() {
	Stack* stack = new ArrayStack();
    string input;
    do {
    	cout << "Enter: ";
    	cin >> input;
    	int num;
    	int a, b;
    	switch (input[0]) {
    		case '+':
    		    a = stack->pop();
    		    b = stack->pop();
    		    stack->push(b + a);
    		    break;
    		case '-':
    		    a = stack->pop();
    		    b = stack->pop();
    		    stack->push(b - a);
    		    break;
    		case '*':
    		    a = stack->pop();
    		    b = stack->pop();
    		    stack->push(b * a);
    		    break;
    		case '/':
    		    a = stack->pop();
    		    b = stack->pop();
    		    stack->push(b / a);
    		    break;
    		case 'x':
    			cout << "Answer is " << stack->pop() << endl;
    			break;
    		default: // number
    			num = stoi(input); // converts string to int
                stack->push(num);
    			break;
		}
	} while (input != "x");
    return 0;
}