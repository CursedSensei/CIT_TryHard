struct node {
	int elem;
	node* left;
	node* right;
	node* parent;

    // TODO implement this method
    int depth() {
        if (parent == nullptr) return 0;
        int ret = 1;
        node *cur = parent;
        
        while (cur->parent) {
            ret++;
            cur = cur->parent;
        }
        return ret;
    }
};