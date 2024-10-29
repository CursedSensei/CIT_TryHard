struct node {
	int elem;
	node* left;
	node* right;
	node* parent;

    // TODO implement this method
    int height() {
        if (!left && !right) {
            return 0;
        }
        
        int leftHeight = 0, rightHeight = 0;
        
        if (left) {
            leftHeight = 1 + left->height();
        }
        if (right) {
            rightHeight = 1 + right->height();
        }
        
        return leftHeight > rightHeight ? leftHeight : rightHeight;
    }
};