class Stack { // Abstract Data Type
	public:
	virtual void push(int e) = 0;
	virtual int pop() = 0;
	virtual int top() = 0;
	virtual int size() = 0;
	virtual bool isEmpty() = 0;
};
