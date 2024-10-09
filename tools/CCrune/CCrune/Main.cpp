#include <iostream>
#include <Windows.h>
#include "Clipboard.h"
using namespace std;

DWORD WINAPI xmain(LPVOID args) {
	HWND *ccHwnd = (HWND*)args;

	initClipboard(*ccHwnd);

	int input = 0;
	while (input != 1) {
		cout << "CCrune Controls\nWARNING: DEFAULT COPY WILL BE DISABLED. U may pause using the control below to be able to use it.\n" << endl; 
		cout << "Copy: \t\t\t\tCtrl-C" << endl;
		cout << "Paste: \t\t\t\tCtrl - V" << endl;
		cout << "Cancel Paste: \t\t\tEnd" << endl;
		cout << "Increase Input Delay: \t\tCtrl - Right" << endl;
		cout << "Decrease Input Delay: \t\tCtrl - Left" << endl;
		cout << "Switch Bank/Clipboard: \t\tCtrl - [1-9]" << endl;
		cout << "Export Current Bank as file: \tCtrl - \\" << endl;
		cout << "Pause / Unpause Clipboard: \tCtrl - .\n\n" << endl;

		cout << "1: Exit\n\nOption: ";
		cin >> input;

		system("cls");
	}

	PostMessageA(*ccHwnd, WM_CLOSE, NULL, NULL);
	HeapFree(GetProcessHeap(), 0, args);

	return 0;
}