#include <Windows.h>

#define CLASSNAME L"CCrune Class"
#define WINDOWNAME L"CCrune Window"

LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

_Use_decl_annotations_ int WINAPI wWinMain(HINSTANCE hInst, HINSTANCE hInstPrev, PWSTR cmdline, int cmdshow) {
	UNREFERENCED_PARAMETER(hInstPrev);
	UNREFERENCED_PARAMETER(cmdline);

	HWND cchWnd = FindWindow(CLASSNAME, WINDOWNAME);
	if (cchWnd != NULL) {
		// Call to show window
		CloseHandle(cchWnd);
		return 0;
	}

	WNDCLASS wc = { };
	wc.lpszClassName = CLASSNAME;
	wc.hInstance = hInst;
	wc.lpfnWndProc = WndProc;

	RegisterClass(&wc);

	cchWnd = CreateWindow(CLASSNAME, WINDOWNAME, WS_OVERLAPPEDWINDOW, 100, 100, 480, 640, NULL, NULL, hInst, NULL);
}

LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	return DefWindowProc(hWnd, uMsg, wParam, lParam);
}