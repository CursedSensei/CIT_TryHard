#include "mybinarytree.hpp"

class BST {
	BinaryTree* tree = new MyBinaryTree();

    node* searchMyNude(node* n, int num) {
		if (n == NULL) {
			return NULL;
		}
		if (n->elem == num) {
			return n;
		}
		if (num > n->elem) {
			return searchMyNude(n->right, num);
		} else {
			return searchMyNude(n->left, num);
		}
	}

	public:
	bool search(int num) {
		return search_node(tree->getRoot(), num);
	}

	bool search_node(node* n, int num) {
		if (n == NULL) {
			return false;
		}
		if (n->elem == num) {
			return true;
		}
		if (num > n->elem) {
			return search_node(n->right, num);
		} else {
			return search_node(n->left, num);
		}
	}

	bool insert(int num) {
		node* n = tree->getRoot();
		if (n == NULL) {
			tree->addRoot(num);
		}
		return insert_node(n, num);
	}

	bool insert_node(node* n, int num) {
		if (n == NULL) {
			return false;
		}
		if (n->elem == num) {
			return false;
		}
		if (num > n->elem) {
			if (!n->right) {
				tree->addRight(n, num);
				return true;
			} else {
				return insert_node(n->right, num);
			}
		} else {
			if (!n->left) {
				tree->addLeft(n, num);
				return true;
			} else {
				return insert_node(n->left, num);
			}
		}
	}

    // TODO predecessor
    int predecessor(int num) {
        node *n = searchMyNude(tree->getRoot(), num);
        if (n == NULL) return -1;
        
        if (n->left) {
            n = tree->left(n);
            while (tree->right(n)) {
                n = tree->right(n);
            }
            return n->elem;
        } else {
            while (n->parent != NULL) {
                if (n->parent->elem < num) return n->parent->elem;
            
                if (tree->left(n->parent) == NULL || tree->left(n->parent) == n) {
                    n = n->parent;
                    continue;
                }
                return tree->left(n->parent)->elem;
            }
        }
    
        return -1;
    }

    // TODO successor
    int successor(int num) {
        node *n = searchMyNude(tree->getRoot(), num);
        if (n == NULL) return -1;
        
        if (tree->right(n)) {
            n = tree->right(n);
            while (tree->left(n)) {
                n = tree->left(n);
            }
            return n->elem;
        } else {
            while (n->parent != NULL) {
                if (n->parent->elem > num) return n->parent->elem;
            
                if (tree->right(n->parent) == NULL || tree->right(n->parent) == n) {
                    n = n->parent;
                    continue;
                }
                
                return tree->right(n->parent)->elem;
            }
        }
    
        return -1;
    }

	void print() {
		tree->print();
	}
};