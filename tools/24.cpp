#include "node.h"
#include <iostream>
using namespace std;

class LinkedList {
	node* head;
	node* tail;
	int size;

	public:
	LinkedList() {
		head = new node;
		tail = new node;
		head->song = NULL;
		tail->song = NULL;
		head->next = tail;
		tail->prev = head;
		size = 0;
	}

	void addSong(Song* s) {

	}

	Song* next() {
	    return NULL;
	}

	bool toggleFavorite() {
	    return false;
	}

	Song* previous() {
	    return NULL;
	}

	Song* play() {
	    return NULL;
	}

	Song* skip() {
	    return NULL;
	}

	Song* skip(int item) {
	    return NULL;
	}

	Song* find(string art) {
		return NULL;
	}

	Song* remove() {
	    return NULL;
	}

	void print() {
		cout << "Song Count: " << size << endl;
		node* c = head->next;
		int i = 1;
		while (c != tail) {
			cout << i++ << ". ";
			c->song->print();
			cout << endl;
			c = c->next;
		}
	}
};