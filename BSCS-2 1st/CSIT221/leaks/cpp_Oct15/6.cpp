#include "stack.h"
#include "linkedlist.h"

class SinglyStack : public Stack, private LinkedList {
    public:
    void push(int n) {
        addHead(n);
    }
    int pop() {
        return removeHead();
    }
    int top() {
        return get();
    }
    int size() {
        return _size();
    }
    bool isEmpty() {
        return _size() <= 0;
    }
    void print() {
        
    }
};