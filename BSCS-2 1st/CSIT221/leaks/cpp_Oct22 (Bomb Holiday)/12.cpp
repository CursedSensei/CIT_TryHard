// TODO implement

#include "deque.h"
#include "linkedlist.h"

class DoublyDeque : public Deque {
    LinkedList *list = new LinkedList();

public:
    void addFirst(int num) {
        list->addHead(num);
    }

    void addLast(int num) {
        list->addTail(num);
    }

    int removeFirst() {
        return list->removeHead();
    }

    int removeLast() {
        return list->removeTail();
    }

    bool isEmpty() {
        return list->getSize() == 0;
    }

    int size() {
        return list->getSize();
    }

    void print() {
        list->print();
    }

};