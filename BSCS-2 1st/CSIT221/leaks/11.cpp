#include<iostream>
#include<string>
#include "arraystack.h"
using namespace std;

// TODO implement this method.
// Use the ArrayStack to perform the stack operations needed.
int is_balanced_parentheses(string str){
    Stack* stack = new ArrayStack();
    
    for (char c : str) {
        switch (c) {
            case ')':
                if (stack->isEmpty()) return 3;
                if (stack->pop() != '(') return 1;
                break;
            case '}':
                if (stack->isEmpty()) return 3;
                if (stack->pop() != '{') return 1;
                break;
            case ']':
                if (stack->isEmpty()) return 3;
                if (stack->pop() != '[') return 1;
                break;
            default:
                stack->push(c);
        }
    }
    
    return stack->isEmpty() ? 0 : 2;
}

int main(){
    string str;
    cout << "Enter a string with parentheses: ";
    cin >> str;
    int res = is_balanced_parentheses(str);
    switch(res) {
        case 0:
            cout << "The parentheses are balanced!" << endl;
            break;
        case 1:
            cout << "The parentheses are not balanced due to mismatch!" << endl;
            break;
        case 2:
            cout << "The parentheses are not balanced due to missing closing parentheses!" << endl;
            break;
        case 3:
            cout << "The parentheses are not balanced due to missing opening parentheses!" << endl;
            break;
    }
    return 0;
}