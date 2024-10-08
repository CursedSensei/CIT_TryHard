#include "node.h"
#include <iostream>
using namespace std;

class LinkedList {
	node* head;
	node* tail;
	int size;
	node* playing = NULL;

    void appendNode(node *prev, node *n) {
        n->next = prev->next;
        prev->next = n;
        n->prev = prev;
        n->next->prev = n;
    }

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
        node *n = new node;
        n->song = s;
        
        if (s->fave) {
            node *cur = head->next;
        
            while (cur != tail && cur->song->fave) {
                cur = cur->next;
            }
            
            appendNode(cur->prev, n);
        } else {
            appendNode(tail->prev, n);
        }
        size++;
	}

	Song* next() {
	    if (playing && playing->next != tail) {
	        playing = playing->next;
	        playing->song->play();
	        return playing->song;
	    }
	    
	    if (!playing && size && head->next != tail) {
	        playing = head->next;
	        playing->song->play();
	        return playing->song;
	    }
	    
	    return NULL;
	}

	bool toggleFavorite() {
	    if (playing) {
	        playing->song->fave = !playing->song->fave;
	        return playing->song->fave;
	    }
	
	    return false;
	}

	Song* previous() {
	    if (playing && playing->prev && playing->prev != head) {
	        playing = playing->prev;
	        playing->song->play();
	        return playing->song;
	    }
	
	    return NULL;
	}

	Song* play() {
	    if (playing) {
	        playing->song->play();
	        return playing->song;
	    }
	
	    return NULL;
	}

	Song* skip() {
	    if (playing && playing->next != tail) {
	        playing->song->skip();
	        playing = playing->next;
	        playing->song->play();
	        return playing->song;
	    }
	
	    return NULL;
	}

	Song* skip(int item) {
	    if (!playing) return NULL;
	
	    node *n = playing;
	
	    for (int i = 0; i < item; i++) {
	        if (n->next == tail) return NULL;
	        n = n->next;
	    }
	    
	    if (n) {
	        playing->song->skip();
	        playing = n;
	        playing->song->play();
	        return n->song;
	    }
	
	    return NULL;
	}

	Song* find(string art) {
	    node *cur = playing ? playing->next : head->next;
	    while (cur != tail) {
	        if (cur->song->artist[0] == art || cur->song->artist[1] == art) {
	            playing = cur;
	            cur->song->play();
	            return cur->song;
	        }
	        cur = cur->next;
	    }
	
		return NULL;
	}

	Song* remove() {
	    if (playing) {
	        size--;
	        Song *ret = playing->song;
	        node *n = playing;
	        
	        playing->prev->next = playing->next;
	        playing->next->prev = playing->prev;
	        
	        if (playing->next != tail) {
	            playing = playing->next;
	        } else if (playing->prev != head) {
	            playing = playing->prev;
	        } else {
	            playing = NULL;
	        }
	        
	        delete n;
	        return ret;
	    }
	
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