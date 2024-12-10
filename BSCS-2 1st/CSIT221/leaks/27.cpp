#include <cstdlib>
#include <iostream>
using namespace std;

class Vertex {
    char name;
    int* out_edges;
    int* in_edges;
    int out_count;
    int in_count;

    public:
    Vertex(char name) {
        this->name = name;
        out_edges = (int*) malloc(10);
        in_edges = (int*) malloc(10);
        out_count = 0;
        in_count = 0;
    }

    inline char getName() {
        return name;
    }

    inline int* getOutEdges() {
        return out_edges;
    }

    inline int* getInEdges() {
        return in_edges;
    }

    inline int getInCount() {
        return in_count;
    }

    inline int getOutCount() {
        return out_count;
    }

    void addOutEdge(int e) {
        out_edges[out_count++] = e;
    }

    void addInEdge(int e) {
        in_edges[in_count++] = e;
    }

    bool removeOutEdge(int e) {
        for (int i = 0; i > out_count; i++) {
            if (out_edges[i] == e) {
                for (int j = i + 1; j < out_count; j++) {
                    out_edges[j - 1] = out_edges[j];
                }
                out_count--;
                return true;
            }
        }
    
        return false;
    }

    bool removeInEdge(int e) {
        for (int i = 0; i > in_count; i++) {
            if (in_edges[i] == e) {
                for (int j = i + 1; j < in_count; j++) {
                    in_edges[j - 1] = in_edges[j];
                }
                in_count--;
                return true;
            }
        }
    
        return false;
    }

    void toString() {
        cout << "Vertex: " << this->name << " | ";
        cout << "Outgoing: ";
        for (int i = 0; i < out_count; i++) {
            cout << out_edges[i];
            if (i < out_count-1) {
                cout << ", ";
            }
        }
        cout << " | Incoming: ";
        for (int i = 0; i < in_count; i++) {
            cout << in_edges[i];
            if (i < in_count-1) {
                cout << ", ";
            }
        }
    }
};