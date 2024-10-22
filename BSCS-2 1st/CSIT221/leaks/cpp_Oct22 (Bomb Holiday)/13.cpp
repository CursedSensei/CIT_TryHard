// TODO implement

class Deque {
public:
    virtual void addFirst(int) = 0;
    virtual void addLast(int) = 0;
    virtual int removeFirst() = 0;
    virtual int removeLast() = 0;
    virtual bool isEmpty() = 0;
    virtual int size() = 0;
    virtual void print() = 0;
};