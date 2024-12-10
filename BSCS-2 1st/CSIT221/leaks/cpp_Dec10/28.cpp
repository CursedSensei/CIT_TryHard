#include <cstdlib>
#include <iostream>
#include "graph.hpp"
#include "vertex.hpp"
using namespace std;
// INCOMEPLETE REMOVE
class GraphList : public Graph {
    Vertex** s_vertices;
    int num_vert;
    int s_edges[100];
    int num_edge;

    int findIndex(char c) {
        for (int i = 0; i < num_vert; i++) {
            if (s_vertices[i]->getName() == c) return i;
        }
        
        return -1;
    }

    public:
    GraphList() {
        s_vertices = (Vertex**) malloc( 10 * sizeof(Vertex*) );
        num_vert = 0;
        num_edge = 0;
    }

    int numVertices() {
        return num_vert;
    }

    char* vertices() {
        static char verts[10];
        
        for (int i = 0; i < num_vert; i++) {
            verts[i] = s_vertices[i]->getName();
        }
    
        return verts;
    }

    int numEdges() {
        return num_edge;
    }

    int* edges() {
        return s_edges;
    }

    int getEdge(char u, char v)  {
        int uIdx = findIndex(u);
        int vIdx = findIndex(v);
        
        if (uIdx == -1 || vIdx == -1) return 0;
        
        int *cur = s_vertices[uIdx]->getOutEdges();
        int *cur2 = s_vertices[vIdx]->getInEdges();
        for (int i = 0; i < s_vertices[uIdx]->getOutCount(); i++) {
            for (int j = 0; j < s_vertices[vIdx]->getInCount(); j++) {
                if (cur[i] == cur2[j]) return cur[i];
            }
        }
        
        cur = s_vertices[uIdx]->getInEdges();
        cur2 = s_vertices[vIdx]->getOutEdges();
        for (int i = 0; i < s_vertices[vIdx]->getOutCount(); i++) {
            for (int j = 0; j < s_vertices[uIdx]->getInCount(); j++) {
                if (cur[i] == cur2[j]) return cur[i];
            }
        }
        
        return 0;
    }

    char* endVertices(int e)  {
        static char vertes[2];
    
        for (int i = 0; i < num_vert; i++) {
            for (int j = 0; j < num_vert; j++) {
                if (i == j) continue;
                
                if (getEdge(s_vertices[i]->getName(), s_vertices[j]->getName()) == e) {
                    vertes[0] = s_vertices[i]->getName();
                    vertes[1] = s_vertices[j]->getName();
                    return vertes;
                }
            }
        }
        
        vertes[0] = '-';
        vertes[1] = '-';
        return vertes;
    }

    char opposite(char v, int e) {
        int idx = findIndex(v);
        
        if (idx == -1) return '-';
    
        for (int i = 0; i < num_vert; i++) {
            if (i == idx) continue;
            
            if (getEdge(s_vertices[i]->getName(), v) == e) {
                return s_vertices[i]->getName();
            }
        }
    
        return '-';
    }

    int outDegree(char v)  {
        int idx = findIndex(v);
        
        if (idx == -1) return 0;
        
        return s_vertices[idx]->getOutCount();
    }

    int inDegree(char v)  {
        int idx = findIndex(v);
        
        if (idx == -1) return 0;
        
        return s_vertices[idx]->getInCount();
    }

    int* outgoingEdges(char v) {
        int idx = findIndex(v);
        
        if (idx == -1) return 0;
        
        return s_vertices[idx]->getOutEdges();
    }

    int* incomingEdges(char v) {
        int idx = findIndex(v);
        
        if (idx == -1) return 0;
        
        return s_vertices[idx]->getInEdges();
    }

    bool insertVertex(char x)  {
        s_vertices[num_vert++] = new Vertex(x);
    
        return true;
    }

    bool insertEdge(char u, char v, int x)  {
        int uIdx = findIndex(u);
        int vIdx = findIndex(v);
        
        if (uIdx == -1 || vIdx == -1) return false;
        
        if (getEdge(u, v)) {
            cout << "Not Null" << endl;
            return false;
        }
        
        s_vertices[uIdx]->addOutEdge(x);
        s_vertices[vIdx]->addInEdge(x);
        
        s_edges[num_edge++] = x;
        
        return true;
    }

    int removeVertex(char v) {
        Vertex * cur = s_vertices[findIndex(v)];
        int *curs = outgoingEdges(v);
        for (int i = 0; i < outDegree(v); i++) {
            Vertex *cur2 = findIndex(opposite(v, curs[i]));
            
        }
    }

    bool removeEdge(int e)  {
        return false;
    }

    void print() {
        for (int i = 0; i < num_vert; i++) {
            s_vertices[i]->toString();
            cout << endl;
        }
    }
};