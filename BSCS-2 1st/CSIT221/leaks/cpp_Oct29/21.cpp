#include <cstdlib>

struct node {
	node **children;
	int num_child;
	node *parent;
	int elem;

    int depth() {
		// TODO implementation [+10 pts]
		
		if (!parent) return 0;
		
		return parent->depth() + 1;
	}


    int height() {
		// TODO implementation [+15 pts]
		
		int hei = 0;
		
		for (int i = 0; i < num_child; i++) {
		    int innerHei = children[i]->height() + 1;
		    if (innerHei > hei) hei = innerHei;
		}
		
		return hei;
    }
};