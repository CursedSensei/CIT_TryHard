#include "mybinarytree.h"

class BST {
	BinaryTree* tree = new MyBinaryTree();
private:
    bool search(int num, node ** n) {
	    node *cur = tree->getRoot();
	
	    if (!cur) return false;
	    
	    while (cur && cur->elem != num) {
	        if (cur->elem > num) {
	            cur = cur->left;
	        } else {
	            cur = cur->right;
	        }
	    }
	    
	    if (cur) {
	        *n = cur;
	        return true;
	    }
	
        return false;
	}


	public:
    // TODO copy from the previous activity
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

    // TODO implement remove method
    // You can add helper methods like what is done for insert and search
    bool remove(int num) {
        node *n;
        
        if (!search(num, &n)) {
            return false;
        }
        
        tree->remove(n);
        return true;
    }

	void print() {
		tree->print();
	}
};