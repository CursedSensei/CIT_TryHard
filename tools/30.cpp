#include <iostream>
#include "linkedlist.h"
using namespace std;
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char** argv) {
	LinkedList* list = new LinkedList();
	char op;
	Song* s;
	int num;
	bool res;
	string art;
	while (true) {
		cout << "Op: ";
		cin >> op;
		switch (op) {
			case 'a':
				s = new Song;
				cout << "Title: ";
				cin >> s->title;
				cout << "Artist: ";
				cin >> s->artist[0] >> s->artist[1];
				cout << "Favorite (1/0)? ";
				cin >> s->fave;
				list->addSong(s);
				break;
			case 'n':
				s = list->next();
				if (s) {
					cout << "Now playing " << s->title << endl;
				} else {
					cout << "No more songs." << endl;
				}
				break;
			case 'b':
				s = list->previous();
				if (s) {
					cout << "Now playing " << s->title << endl;
				} else {
					cout << "No more songs." << endl;
				}
				break;
			case 's':
				s = list->skip();
				if (s) {
					cout << "Skipped. Now playing " << s->title << endl;
				} else {
					cout << "No more songs." << endl;
				}
				break;
			case '>':
				cin >> num;
				s = list->skip(num);
				if (s) {
					cout << "Skipped " << num << " songs. Now playing " << s->title << endl;
				} else {
					cout << "No more songs." << endl;
				}
				break;
			case 'f':
				cin >> art;
				s = list->find(art);
				if (s) {
					cout << "Now playing " << s->title << endl;
				} else {
					cout << "No more songs by " << art << endl;
				}
				break;
			case 'l':
				res = list->toggleFavorite();
				if (res) {
					cout << "Marked as favorite" << endl;
				} else {
					cout << "Unmarked as favorite" << endl;
				}
				break;
			case '+':
				s = list->play();
				if (s) {
					cout << "Playing " << s->title << endl;
				} else {
					cout << "No song selected." << endl;
				}
				break;
			case 'p':
				list->print();
				break;
			case 'r':
				s = list->remove();
				if (s) {
					cout << "Removed " << s->title << endl;
				} else {
					cout << "No song to remove." << endl;
				}
				break;
			case 'x':
				cout << "Closing";
				return 0;
			default:
				cout << "Invalid op." << endl;
				break;
		}
	}
	return 0;
}