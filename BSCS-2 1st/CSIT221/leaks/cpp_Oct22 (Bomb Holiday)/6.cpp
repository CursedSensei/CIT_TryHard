#include <iostream>
#include "singlyqueue.h"
using namespace std;

// TODO 2: Implement the method and return a queue that contains only the passing scores.
Queue* passing_only(Queue* scores, int passing) {
    Queue* queue = new SinglyQueue();
    int score;
    while (!scores->isEmpty()) {
        score = scores->dequeue();
        if (score >= passing) queue->enqueue(score);
    }
    return queue;
}

int main() {
    Queue* queue = new SinglyQueue();
    int passing;
    int input = 1;

    while (input != 0) {
        cout << "Enter score: ";
        cin >> input;
        if (input) queue->enqueue(input);
    }

    cout << "Enter passing score: ";
    cin >> passing;
    
    // DO NOT MODIFY the following code.
    Queue* res = passing_only(queue, passing);
    cout << "Passing scores: ";
    if (res->isEmpty()) {
        cout << "(none)";
    }
    while (!res->isEmpty()) {
        cout << res->dequeue() << " ";
    }
    
    return 0;
}