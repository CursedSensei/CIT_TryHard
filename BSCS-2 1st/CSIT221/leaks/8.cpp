#include <cstdlib>
#include <iostream>
#include <queue>
#include <stack>
#include "graph.hpp"
using namespace std;

class GraphMatrix : public Graph {
    int matrix[10][10];
    char s_vertices[10];
    int num_vert;
    int s_edges[100];
    int num_edge;

    bool isInside(char *arr, int arrLen, char v) {
        for (int i = 0; i < arrLen; i++) {
            if (arr[i] == v) {
                return true;
            }
        }
        
        return false;
    }

    public:
    GraphMatrix() {
        num_vert = 0;
        num_edge = 0;
    }

    // TODO traversals
    void depthFirst(char v) {
        stack<char> qu;
        char visited[num_vert];
        int visitedLen = 0;
        
        qu.push(v);
        
        while (!qu.empty()) {
            char cur = qu.top();
            qu.pop();
            
            if (!isInside(visited, visitedLen, cur)) {
                visited[visitedLen++] = cur;
                cout << cur << " ";
                
                int idx;
                for (idx = 0; idx < num_vert; idx++) {
                    if (s_vertices[idx] == cur) break;
                }
                
                for (int i = num_vert - 1; i >= 0; i--) {
                    if (matrix[idx][i] != 0 && !isInside(visited, visitedLen, s_vertices[i])) {
                        qu.push(s_vertices[i]);
                    }
                }
            }
        }
    }

    void breadthFirst(char v) {
        queue<char> qu;
        char visited[num_vert];
        int visitedLen = 0;
        
        qu.push(v);
        
        while (!qu.empty()) {
            char cur = qu.front();
            qu.pop();
            
            if (!isInside(visited, visitedLen, cur)) {
                visited[visitedLen++] = cur;
                cout << cur << " ";
                
                int idx;
                for (idx = 0; idx < num_vert; idx++) {
                    if (s_vertices[idx] == cur) break;
                }
                
                for (int i = 0; i < num_vert; i++) {
                    if (matrix[idx][i] != 0 && !isInside(visited, visitedLen, s_vertices[i])) {
                        qu.push(s_vertices[i]);
                    }
                }
            }
        }
    }

    // IGNORE the functions below
    int numVertices() {
        return 0;
    }

    char* vertices() {
        return NULL;
    }

    int numEdges() {
        return 0;
    }

    int* edges() {
        return NULL;
    }

    int getEdge(char u, char v)  {
        return 0;
    }

    char* endVertices(int e)  {
        return NULL;
    }

    char opposite(char v, int e)  {
        return '-';
    }

    int outDegree(char v)  {
        return 0;
    }

    int inDegree(char v)  {
        return 0;
    }

    int* outgoingEdges(char v) {
        return NULL;
    }

    int* incomingEdges(char v) {
        return NULL;
    }

    bool insertVertex(char x)  {
        s_vertices[num_vert] = x;
        num_vert++;
        return true;
    }

    bool insertEdge(char u, char v, int x)  {
        int u_ind = 0, v_ind = 0;
        for (int i = 0; i < num_vert; i++) {
            if (u == s_vertices[i]) {
                u_ind = i;
            }
            if (v == s_vertices[i]) {
                v_ind = i;
            }
        }
        if (matrix[u_ind][v_ind] != 0) {
            cout << "Not null" << endl;
            return false;
        }
        matrix[u_ind][v_ind] = x;
        s_edges[num_edge] = x;
        num_edge++;
        return true;
    }

    int removeVertex(char v) {
        return 0;
    }

    bool removeEdge(int e)  {
        return false;
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