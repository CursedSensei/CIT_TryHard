#include <Windows.h>
#include "resource.h"
#include "WindowCodes.h"

NOTIFYICONDATAA nid = {};
bool shown = false;

void addTray(HINSTANCE hInst, HWND hwd) {
	nid.cbSize = sizeof(NOTIFYICONDATAA);
	nid.hWnd = hwd;
	nid.uFlags = NIF_TIP | NIF_MESSAGE | NIF_ICON | NIF_STATE;
	nid.hIcon = LoadIcon(hInst, MAKEINTRESOURCE(IDI_CCrune));
	strcpy_s(nid.szTip, "CCrune - :P");
	nid.dwStateMask = NIS_HIDDEN;
	nid.dwState = NIS_HIDDEN;
	nid.uCallbackMessage = APP_TRAY;

	Shell_NotifyIconA(NIM_ADD, &nid);
}

void remTray() {
	Shell_NotifyIconA(NIM_DELETE, &nid);
}

void showTray() {
	shown = true;
	nid.dwState = NULL;
	Shell_NotifyIconA(NIM_MODIFY, &nid);
}

bool hideTray() {
	if (!shown) return false;
	shown = false;
	nid.dwState = NIS_HIDDEN;
	Shell_NotifyIconA(NIM_MODIFY, &nid);

	return true;
}