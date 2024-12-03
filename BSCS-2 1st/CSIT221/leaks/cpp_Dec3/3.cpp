#include <cstdlib>
#include <iostream>
#include "graph.h"
using namespace std;

class GraphMatrix : public Graph {
    int matrix[10][10];
    char s_vertices[10];
    int num_vert;
    int s_edges[100];
    int num_edge;

    int getIndex(char c) {
        for (int i = 0; i < num_vert; i++) {
            if (s_vertices[i] == c) {
                return i;
            }
        }
        return -1;
    }
    
    bool removeDisEdge(int e) {
        bool letsRemove = false;
    
        for (int i = 0; i < num_edge; i++) {
            if (letsRemove) {
                s_edges[i - 1] = s_edges[i];
            } else if (s_edges[i] == e) {
                letsRemove = true;
            }
        }
        
        if (letsRemove) num_edge--;
        return letsRemove;
    }

    public:
    GraphMatrix() {
        num_vert = 0;
        num_edge = 0;
    }

    int numVertices() {
        return num_vert;
    }

    char* vertices() {
        return s_vertices;
    }

    int numEdges() {
        return num_edge;
    }

    int* edges() {
        return s_edges;
    }

    int getEdge(char u, char v)  {
        int idxU = getIndex(u);
        int idxV = getIndex(v);
        
        if (idxU == -1 || idxV == -1) return 0;
        
        return matrix[idxU][idxV];
    }

    char* endVertices(int e) {
        static char verts[2];
    
        for (int i = 0; i < num_vert; i++) {
            for (int j = 0; j < num_vert; j++) {
                if (matrix[i][j] == e) {
                    verts[0] = s_vertices[i];
                    verts[1] = s_vertices[j];
                    return verts;
                }
            }
        }
    
        verts[0] = '-';
        verts[1] = '-';
        return verts;
    }

    char opposite(char v, int e)  {
        int idx = getIndex(v);
        
        if (idx == -1) return '-';
    
        for (int i = 0; i < num_vert; i++) {
            if (matrix[idx][i] == e || matrix[i][idx] == e) {
                return s_vertices[i];
            }
        }
    
        return '-';
    }

    int outDegree(char v)  {
        int ret = 0;
        
        int idx = getIndex(v);
        
        if (idx == -1) return 0;
        
        for (int i = 0; i < num_vert; i++) {
            if (matrix[idx][i]) ret++;
        }
    
        return ret;
    }

    int inDegree(char v)  {
        int ret = 0;
        
        int idx = getIndex(v);
        
        if (idx == -1) return 0;
        
        for (int i = 0; i < num_vert; i++) {
            if (matrix[i][idx]) ret++;
        }
    
        return ret;
    }

    int* outgoingEdges(char v) {
        static int ret[100];
        int ret_num = 0;
        
        int idx = getIndex(v);
        
        if (idx == -1) return 0;
        
        for (int i = 0; i < num_vert; i++) {
            if (matrix[idx][i]) {
                ret[ret_num++] = matrix[idx][i];
            }
        }
    
        return ret;
    }

    int* incomingEdges(char v) {
        static int ret[100];
        int ret_num = 0;
        
        int idx = getIndex(v);
        
        if (idx == -1) return 0;
        
        for (int i = 0; i < num_vert; i++) {
            if (matrix[i][idx]) {
                ret[ret_num++] = matrix[i][idx];
            }
        }
    
        return ret;
    }

    bool insertVertex(char x)  {
        if (num_vert == 10) return false;
    
        s_vertices[num_vert++] = x;
        return true;
    }

    bool insertEdge(char u, char v, int x)  {
        if (num_edge == 100) return false;
        
        int idxU = getIndex(u);
        int idxV = getIndex(v);
        
        if (idxU == -1 || idxV == -1) return false;
        
        if (matrix[idxU][idxV]) {
            cout << "Not Null" << endl;
            return false;
        }
        
        matrix[idxU][idxV] = x;
        s_edges[num_edge++] = x;
    
        return true;
    }
    
    int removeVertex(char v) {
        int idx = getIndex(v);
        if (idx == -1) return 0;
        
        int sum = 0;
        sum += inDegree(v);
        sum += outDegree(v);
        
        int *edges = incomingEdges(v);
        for (int i = inDegree(v) - 1; i >= 0; i--) {
            removeDisEdge(edges[i]);
        }
        
        edges = outgoingEdges(v);
        for (int i = outDegree(v) - 1; i >= 0; i--) {
            removeDisEdge(edges[i]);
        }
        
        for (int i = idx; i < num_vert; i++) {
            s_vertices[i] = s_vertices[i+1];
        }
        
        int i;
        
        while (idx < num_vert) {
            for (i = 0; i < num_vert; i++) {
                matrix[i][idx] = matrix[i][idx + 1];
            }
            for (i = 0; i < num_vert; i++) {
                matrix[idx][i] = matrix[idx + 1][i];
            }
            idx++;
        }
        
        num_vert--;
        return sum;
    }


    bool removeEdge(int e)  {
        bool found = removeDisEdge(e);
        if (!found) return found;
        
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
                if (e == matrix[i][j]) {
                    matrix[i][j] = 0;
                    return found;
                }
            }
        }
        
        return found;
    }

    void print() {
        cout << "\t";
        for (int i = 0; i < num_vert; i++) {
            cout << s_vertices[i] << "\t";
        }
        cout << endl;
        for (int i = 0; i < num_vert; i++) {
            cout << s_vertices[i] << "\t";
            for (int j = 0; j < num_vert; j++) {
                if (matrix[i][j] != 0) {
                    cout << matrix[i][j];
                }
                cout << "\t";
            }
            cout << endl;
        }
    }
};