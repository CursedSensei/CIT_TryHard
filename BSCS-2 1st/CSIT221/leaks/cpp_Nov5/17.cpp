#include <string>
using namespace std;

struct node {
	string elem;
	node* left;
	node* right;
	node* parent;

    // TODO evaluate method
    int evaluate() {
        switch (elem[0]) {
            case '+':
                return left->evaluate() + right->evaluate();
            case '-':
                return left->evaluate() - right->evaluate();
            case '/':
                return left->evaluate() / right->evaluate();
            case '*':
                return left->evaluate() * right->evaluate();
        }
        
        return stoi(elem);
    }
};