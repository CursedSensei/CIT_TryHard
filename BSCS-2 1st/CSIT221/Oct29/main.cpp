#include <iostream>
#include "btree.h"
using namespace std;
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char** argv) {
	BinaryTree* tree = new BinaryTree();
	node* nine = tree->addRoot(9);
	node* thirteen = tree->addLeft(nine, 13);
	node* twenty = tree->addLeft(thirteen, 20);
	tree->print();
	return 0;
}
