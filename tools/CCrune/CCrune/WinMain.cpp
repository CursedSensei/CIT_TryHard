#include <Windows.h>
#include <stdio.h>
#include "WindowCodes.h"

#define CLASSNAME L"CCrune Class"
#define WINDOWNAME L"CCrune Window"

bool CreateConsole();
HWND initWindow(HINSTANCE hInst);
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

	cchWnd = initWindow(hInst);
	
	if (!cchWnd) return 1;

	MSG uMsg;

	while (GetMessage(&uMsg, NULL, NULL, NULL)) {
		TranslateMessage(&uMsg);
		DispatchMessageW(&uMsg);
	}

	return 0;
}

LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	switch (uMsg) {
	case APP_WC_SHOW:
		break;
	case APP_WC_CONSOLE:
		break;
	case APP_WC_SYSTEMTRAY:
		break;
	case WM_PAINT:
	{
		PAINTSTRUCT ps;
		POINT cP;
		ZeroMemory(&cP, sizeof(POINT));

		HDC hdc = BeginPaint(hWnd, &ps);
		HDC sHdc = GetDC(NULL);
		ClientToScreen(hWnd, &cP);
		HDC tempDc = CreateCompatibleDC(sHdc);
		HBITMAP sBt = CreateCompatibleBitmap(tempDc, 30, 30);
		DeleteObject(SelectObject(tempDc, sBt));
		BitBlt(tempDc, 0, 0, 30, 30, sHdc, cP.x, cP.y, SRCCOPY);

		DeleteDC(sHdc);

		
	}
		break;
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	default:
		return DefWindowProc(hWnd, uMsg, wParam, lParam);
	}
	return 0;
}

HWND initWindow(HINSTANCE hInst) {
	WNDCLASS wc = { };
	wc.lpszClassName = CLASSNAME;
	wc.hInstance = hInst;
	wc.lpfnWndProc = WndProc;

	RegisterClass(&wc);

	DWORD posOffset = GetSystemMetrics(SM_CYSCREEN) * 0.0278;
	return CreateWindowEx(WS_EX_NOACTIVATE | WS_EX_TOPMOST, CLASSNAME, WINDOWNAME, WS_POPUP | WS_DISABLED, posOffset, GetSystemMetrics(SM_CYSCREEN) - posOffset - 60, 30, 30, NULL, NULL, hInst, NULL);
}

bool CreateConsole() {
	bool ret = AllocConsole();

	if (!ret) return ret;

	FILE* fp;
	freopen_s(&fp, "CONOUT$", "w", stdout);
	freopen_s(&fp, "CONOUT$", "w", stderr);
	freopen_s(&fp, "CONIN$", "r", stdin);

	return ret;
}