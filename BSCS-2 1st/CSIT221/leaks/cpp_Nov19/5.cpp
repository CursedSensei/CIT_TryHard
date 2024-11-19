#include "mybinarytree.h"

class BST {
	BinaryTree* tree = new MyBinaryTree();

	public:
	bool search(int num) {
	    node *cur = tree->getRoot();
	
	    if (!cur) return false;
	    
	    while (cur && cur->elem != num) {
	        if (cur->elem > num) {
	            cur = cur->left;
	        } else {
	            cur = cur->right;
	        }
	    }
	    
	    if (cur) return true;
	
        return false;
	}

	bool insert(int num) {
        node *cur = tree->getRoot();
        
        if (!cur) {
            tree->addRoot(num);
            return true;
        }
        
        do {
            if (cur->elem == num) return false;
            else if (cur->elem > num) {
                if (!cur->left) {
                    tree->addLeft(cur, num);
                    return true;
                }
                cur = cur->left;
            } else {
                if (!cur->right) {
                    tree->addRight(cur, num);
                    return true;
                }
                cur = cur->right;
            }
        } while (true);
	}

	void print() {
		tree->print();
	}
};