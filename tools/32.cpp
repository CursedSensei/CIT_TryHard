#include <iostream>
using namespace std;
struct Song {
	string title;
	bool fave;
	int played = 0;
	string artist[2];

	void print() {
		cout << title << " by ";
		if (artist[1] == "na") {
			cout << artist[0];
		} else {
			cout << artist[0] << ", " << artist[1];
		}
		cout << " #" << played;
		if (fave) {
			cout << " *";
		}
	}
	
	void play() {
	    played++;
	    if (played > 5) fave = true;
	}
	
	void skip() {
	    played--;
	    if (played < 0) played = 0;
	}
};