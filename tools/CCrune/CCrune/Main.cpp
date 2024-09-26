#include <Windows.h>
#include "Clipboard.h"
#include <iostream>

using namespace std;

int main() {
	bool silenceTab = false;


	int input = 0;
	while (input != 1) {
		cout << "CCrune Controls\n\nCopy (Default copy is disabled): Ctrl-C\nPaste: Ctrl-V\nCancel Paste: Ctrl-End\n\n\n1: Start\n2: Toggle Tab (" << (silenceTab ? "Tabs will not be inputted)" : "Tabs will be inputted)") << "\n\nOption: ";
		cin >> input;

		switch (input) {
		case 2:
			silenceTab = !silenceTab;
			break;
		}
		system("cls");
	}

	initClipboard(silenceTab);

	input = 0;
	while (input != 2) {
		cout << "CCrune Running\n\nCopy (Default copy is disabled): Ctrl-C\nPaste: Ctrl-V\nCancel Paste: Ctrl-End\n\n\n1: Toggle Tab (" << (silenceTab ? "Tabs will not be inputted)" : "Tabs will be inputted)") << "\n2: Exit\n\nOption: ";
		cin >> input;

		switch (input) {
		case 1:
			silenceTab = !silenceTab;
			setTab(silenceTab);
			break;
		}

		system("cls");
	}

	return 0;
}