#include "node.h"

class LinkedList {
	node* head;
	node* tail;
	int size;

    void nodeInsertAfter(node *dest, node *src) {
        src->next = dest->next;
        src->prev = dest;
        dest->next = src;
        src->next->prev = src;
    }
    
    void removeNode(node *src) {
        src->prev->next = src->next;
        src->next->prev = src->prev;
        delete src;
        size--;
    }

	public:
	LinkedList() {
		head = new node;
		tail = new node;
		head->next = tail;
		tail->prev = head;
		size = 0;
	}

	// TODO add a person
	void add(Person* p) {
	    node *cur;
	    node *pNode = new node;
	    pNode->person = p;
	    
	    if (p->age >= 60) {
	        cur = head;
	        while (cur->next != tail) {
                if (p->age >= 60 && cur->next->person->age < 60) {
                    break;
                }
                cur = cur->next;
            }
	    } else {
	        cur = tail->prev;
	    }
        
        nodeInsertAfter(cur, pNode);
        size++;
	}

	// TODO serve the request
	Person* serveRequest(char ch) {
	    int ind;
	    
	    switch (ch) {
	        case 'B':
	            ind = 0;
	            break;
	        case 'M':
	            ind = 1;
	            break;
	        case 'C':
	            ind = 2;
	            break;
	        case 'D':
	            ind = 3;
	            break;
	    }
	
	    node * cur = head;
	    while (cur->next != tail) {
	        cur = cur->next;
	        if (cur->person->requests[ind] == 1) {
	            cur->person->requests[ind] = 0;
	            if (cur->person->noRequests()) {
	                Person * pTemp = cur->person;
	                removeNode(cur);
	                return pTemp;
	            }
	            return cur->person;
	        }
	    }
	    return NULL;
	}

	// TODO serve the request
	Person* fastLane() {
	    node * cur = head;
	
	    while (cur->next != tail) {
	        cur = cur->next;
	        if (cur->person->oneRequest()) {
	            Person * pTemp = cur->person;
	            removeNode(cur);
	            return pTemp;
	        }
	    }
	    return NULL;
	}

	// TODO print
	void print() {
		cout << "Counter: " << size << endl;

		cout << "From First: " << endl;
		node *cur = head->next;
		for (int i = 1; i <= size; i++) {
		    cur->person->toPrint(i);
		    cur = cur->next;
		}

		cout << "From Last: " << endl;
        for (int i = size; i > 0; i--) {
            cur = cur->prev;
		    cur->person->toPrint(i);
		}
	}
};



#include <iostream>
using namespace std;

struct Person {
	string firstName;
	string lastName;
	int age;
	int requests[4];

	void print_name() {
		cout << firstName << " " << lastName << endl;
	}
	
	void toPrint(int idx) {
		cout << idx << ". " << firstName << " " << lastName << " (" << age << ") - req: ";
		
		for (int i = 0; i < 4; i++) {
		    if (requests[i] != 0) {
		        switch (i) {
		            case 0:
		                cout << "B ";
		                break;
		            case 1:
		                cout << "M ";
		                break;
		            case 2:
		                cout << "C ";
		                break;
		            case 3:
		                cout << "D ";
		                break;
		        }
		    }
		}
		
		cout << endl;
	}
	
	bool noRequests() {
	    for (int i = 0; i < 4; i++) {
	        if (requests[i] == 1) return false;
	    }
	    return true;
	}
	
	bool oneRequest() {
	    bool one = false;
	    
	    for (int i = 0; i < 4; i++) {
	        if (requests[i] == 1) {
	            if (one) return false;
	            one = !one;
	        }
	    }
	    
	    return one;
	}
};



#include "node.h"

class LinkedList {
	node* head;
	node* tail;
	int size;

    void swapNode(node *dest, node *src) {
        if(dest->next == src) {
            src->prev = dest->prev;
            dest->next = src->next;
            dest->prev = src;
            src->next = dest;
            
            src->next->prev = src;
            src->prev->next = src;
            
            dest->next->prev = dest;
            dest->prev->next = dest;
            return;
        } else if (dest->prev == src) {
            src->next = dest->next;
            dest->prev = src->prev;
            dest->next = src;
            src->prev = dest;
            
            src->next->prev = src;
            src->prev->next = src;
            
            dest->next->prev = dest;
            dest->prev->next = dest;
            return;
        }
    
        node *temp = dest->next;
        dest->next = src->next;
        src->next = temp;
        
        temp = src->prev;
        src->prev = dest->prev;
        dest->prev = temp;
        
        src->next->prev = src;
        src->prev->next = src;
        
        dest->next->prev = dest;
        dest->prev->next = dest;
    }

	public:
	LinkedList() {
		head = new node;
		tail = new node;
		head->next = tail;
		tail->prev = head;
		size = 0;
	}

	// TODO add a person
	void add(Person* p) {
        node *pNode = new node;
        pNode->person = p;
        
        pNode->prev = tail->prev;
        pNode->next = tail;
        pNode->prev->next = pNode;
        tail->prev = pNode;
        
        size++;
	}

	// TODO advance
	void advance(string name, int forward) {
        node *cur = head->next;
        
        while (!(cur->person->firstName == name || cur->person->lastName == name)) {
            cur = cur->next;
        }
        
        for (int i = forward; i > 0; i--) {
            if (cur->prev == head) break;
            swapNode(cur->prev, cur);
        }
	}


	// TODO delay
	void delay(string name, int back) {
        node *cur = head->next;
        
        while (!(cur->person->firstName == name || cur->person->lastName == name)) {
            cur = cur->next;
        }
        
        node *swapMe = cur;
        for (int i = back; i > 0; i--) {
            if (swapMe->next == tail) break;
            swapMe = swapMe->next;
            swapNode(swapMe, cur);
        }
	}


	// TODO trade places
	void trade(string name1, string name2) {
        node *cur = head->next;
        
        while (!(cur->person->firstName == name1 || cur->person->lastName == name1)) {
            cur = cur->next;
        }
        
        node *swapMe = head->next;
        while (!(swapMe->person->firstName == name2 || swapMe->person->lastName == name2)) {
            swapMe = swapMe->next;
        }
        
        swapNode(swapMe, cur);
	}

	// TODO print
	void print() {
		cout << "Counter: " << size << endl;

		cout << "From First: " << endl;
		node *cur = head->next;
		for (int i = 1; i <= size; i++) {
		    cur->person->toPrint(i);
		    cur = cur->next;
		}

		cout << "From Last: " << endl;
        for (int i = size; i > 0; i--) {
            cur = cur->prev;
		    cur->person->toPrint(i);
		}
	}
};



#include <iostream>
using namespace std;

struct Person {
	string firstName;
	string lastName;
	int age;
	int requests[4];

	void print_name() {
		cout << firstName << " " << lastName << endl;
	}
	
	void toPrint(int idx) {
    	cout << idx << ". " << firstName << " " << lastName << " (" << age << ") - req: ";
    	
    	for (int i = 0; i < 4; i++) {
    	    if (requests[i] == 0) continue;
    	    switch (i) {
    	        case 0:
    	            cout << "B ";
    	            break;
    	        case 1:
    	            cout << "M ";
    	            break;
    	        case 2:
    	            cout << "C ";
    	            break;
    	        case 3:
    	            cout << "D ";
    	            break;
    	    }
    	}
    	
    	cout << endl;
	}
	
};



