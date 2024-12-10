#include <iostream>
#include <string>
#include <vector>
#include "arraystack.hpp"
using namespace std;

int main() {
    // Step 1: Create the stack instance
    ArrayStack* st = new ArrayStack();
    int len;
    // Step 2: Ask the user for number of items to be inputted.
    cout << "Enter number of inputs: ";
    cin >> len;
    // Step 3: Initialize a string array and place all items there.
    cout << "Enter expression: ";
    vector<string> str;
    string s;
    for (int i = 0; i < len; i++) {
        cin >> s;
        str.push_back(s);
    }
    
    int a, b;
    while (len--) {
        switch (str[len][0]) {
            case '+':
                a = st->top();
                st->pop();
                b = st->top();
                st->pop();
                st->push(a + b);
                break;
            case '-':
                a = st->top();
                st->pop();
                b = st->top();
                st->pop();
                st->push(a - b);
                break;
            case '*':
                a = st->top();
                st->pop();
                b = st->top();
                st->pop();
                st->push(a * b);
                break;
            case '/':
                a = st->top();
                st->pop();
                b = st->top();
                st->pop();
                st->push(a / b);
                break;
            default:
                st->push(stoi(str[len]));
        }
    }
    
    cout << "Answer is " << st->top() << endl;
    
    delete st;
    // Step 4: Loop the array from last to first
        // Step 5: Use a switch statement to identify operations and operators.
    // Step 6: When loop is done, output the answer.
}