#include <Windows.h>
#include <stdio.h>
#include "WindowCodes.h"
#include "resource.h"
#include "Main.h"

#define CLASSNAME L"CCrune Class"
#define WINDOWNAME L"CCrune Window"

namespace statusAssets {
	HBITMAP Current = NULL;

	HBITMAP Copy = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_COPY), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Delay = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_DELAY), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Forward = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_FORWARD), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP NoSemi = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_NOSEMI), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Semi = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_SEMI), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP NoTab = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_NOTAB), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Tab = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_TAB), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Play = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_PLAY), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Pause = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_PAUSE), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Export = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_EXPORT), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);

	HBITMAP Banks[9];

	void load(HWND hWnd) {
		HDC hdc = GetDC(hWnd);
		HDC compatHdc = CreateCompatibleDC(hdc);
		HBITMAP oldBitmap;
		HFONT fontText = CreateFont(20, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, NULL);
		DeleteObject(SelectObject(compatHdc, fontText));
		RECT clientRect;
		clientRect.left = 0;
		clientRect.right = 30;
		clientRect.top = 6;
		clientRect.bottom = 30;

		for (char i = '1'; i <= '9'; i++) {
			HBITMAP compatBitmap = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_BANK), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
			oldBitmap = (HBITMAP)SelectObject(compatHdc, compatBitmap);

			DrawTextA(compatHdc, &i, 1, &clientRect, DT_VCENTER | DT_CENTER);

			Banks[i - '1'] = (HBITMAP)SelectObject(compatHdc, oldBitmap);
		}

		DeleteDC(compatHdc);
		DeleteObject(fontText);
		ReleaseDC(hWnd, hdc);
	}
}

bool CreateConsole();
HWND initWindow(HINSTANCE hInst);
LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

_Use_decl_annotations_ int WINAPI wWinMain(HINSTANCE hInst, HINSTANCE hInstPrev, PWSTR cmdline, int cmdshow) {
	UNREFERENCED_PARAMETER(hInstPrev);
	UNREFERENCED_PARAMETER(cmdline);

	HWND cchWnd = FindWindow(CLASSNAME, WINDOWNAME);
	if (cchWnd != NULL) {
		CloseHandle(cchWnd);
		return 0;
	}

	cchWnd = initWindow(hInst);
	
	if (!cchWnd) return 1;

	statusAssets::load(cchWnd);
	SetLayeredWindowAttributes(cchWnd, RGB(255, 93, 0), 255, LWA_ALPHA | LWA_COLORKEY);

	if (!CreateConsole()) {
		return 2;
	}

	HWND *args = (HWND *)HeapAlloc(GetProcessHeap(), 0, sizeof(HWND));
	if (!args) {
		return 3;
	}

	*args = cchWnd;

	HANDLE tHandle = CreateThread(nullptr, 0, xmain, (LPVOID)args, 0, nullptr);

	if (!tHandle) {
		HeapFree(GetProcessHeap(), 0, args);
		return 3;
	}

	CloseHandle(tHandle);

	MSG uMsg;

	while (GetMessage(&uMsg, NULL, NULL, NULL)) {
		TranslateMessage(&uMsg);
		DispatchMessageW(&uMsg);
	}

	return 0;
}

UINT32 delay = -1;

LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	switch (uMsg) {
	case APP_WC_SHOW:
		switch (wParam) {
		case APP_SHOW_COPY:
			statusAssets::Current = statusAssets::Copy;
			break;
		case APP_SHOW_BANK:
			if (lParam < 0 || lParam > 8) return 0;
			statusAssets::Current = statusAssets::Banks[lParam];
			break;
		case APP_SHOW_EXPORT:
			statusAssets::Current = statusAssets::Export;
			break;
		case APP_SHOW_DELAY:
			statusAssets::Current = lParam ? statusAssets::Delay : statusAssets::Forward;
			break;
		case APP_SHOW_PAUSED:
			statusAssets::Current = lParam ? statusAssets::Pause : statusAssets::Play;
			break;
		case APP_SHOW_TAB:
			statusAssets::Current = lParam ? statusAssets::Tab : statusAssets::NoTab;
			break;
		case APP_SHOW_SEMICOLON:
			statusAssets::Current = lParam ? statusAssets::Semi : statusAssets::NoSemi;
			break;
		default:
			return 0;
		}
		if (delay == -1) {
			ShowWindow(hWnd, SW_SHOW);
		}
		delay = 500;
		break;
	case APP_WC_CONSOLE:
		InvalidateRect(hWnd, NULL, TRUE);
		break;
	case APP_WC_SYSTEMTRAY:
		break;
	case WM_PAINT:
	{
		if (delay == 0) {
			ShowWindow(hWnd, SW_HIDE);
			delay--;
			return DefWindowProc(hWnd, uMsg, wParam, lParam);
		}
		else if (delay == -1) {
			return DefWindowProc(hWnd, uMsg, wParam, lParam);
		}

		SetLayeredWindowAttributes(hWnd, RGB(255, 93, 0), (delay > 255 ? 255 : delay), LWA_ALPHA | LWA_COLORKEY);

		PAINTSTRUCT ps;
		HDC hdc = BeginPaint(hWnd, &ps);
		
		HDC tempDc = CreateCompatibleDC(hdc);
		DeleteObject(SelectObject(tempDc, statusAssets::Current));

		BitBlt(hdc, 0, 0, 30, 30, tempDc, 0, 0, SRCCOPY);

		DeleteDC(tempDc);

		EndPaint(hWnd, &ps);

		Sleep(2);
		delay -= 2;
		InvalidateRect(hWnd, NULL, TRUE);
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
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);

	RegisterClass(&wc);

	DWORD posOffset = GetSystemMetrics(SM_CYSCREEN) * 0.0278;
	return CreateWindowEx(WS_EX_NOACTIVATE | WS_EX_TOPMOST | WS_EX_LAYERED, CLASSNAME, WINDOWNAME, WS_POPUP, posOffset, GetSystemMetrics(SM_CYSCREEN) - posOffset - 60, 30, 30, NULL, NULL, hInst, NULL);
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