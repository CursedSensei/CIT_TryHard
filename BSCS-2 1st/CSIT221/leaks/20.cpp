#include <iostream>
#include <stack>
#include <cctype>

using namespace std;

class node {
public:
    node() {
        len = 0;
    }
    
    int len;
    int pos;
};

int main() {
    stack<node> st;
    
    string input;
    
    cout << "Enter encoded string: ";
    
    cin >> input;
    
    cout << "Result: ";
    
    node n = node();
    n.len = 0;
    for (int i = 0; i < input.length(); i++) {
        if (isdigit(input[i])) {
            n.len *= 10;
            n.len += input[i] - '0';
            continue;
        }
        switch (input[i]) {
            case '[':
                n.pos = i;
                st.push(n);
                n = node();
                break;
            case ']':
                n = st.top();
                st.pop();
                n.len--;
                if (n.len != 0) {
                    i = n.pos;
                    st.push(n);
                }
                n = node();
                break;
            default:
                cout << input[i];
        }
    }
    
    cout << endl;
    
    return 0;
}