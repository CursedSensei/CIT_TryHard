#include <iostream>
#include "graphmatrix.hpp"
using namespace std;

int main(void) {
    char op, v, x;
    char orig, dest;
    int e;

    int num, i;
    char* verts;
    int* edges;
    Graph* graph = new GraphMatrix();
    do {
        cout << "Operation: ";
        cin >> op;
        switch (op) {
            case 'v':
                cin >> v;
                graph->insertVertex(v);
                break;
            case 'e':
                cin >> orig;
                cin >> dest;
                cin >> e;
                graph->insertEdge(orig, dest, e);
                break;
            case 'b':
            	cin >> orig;
                graph->breadthFirst(orig);
                cout << endl;
                break;
            case 'd':
            	cin >> orig;
                graph->depthFirst(orig);
                cout << endl;
                break;
            case 'p':
                graph->print();
                break;
            case 'x':
                cout << "Exiting...";
                break;
            default:
                cout << "Invalid operation";
        }
    } while (op != 'x');

    return 0;
}