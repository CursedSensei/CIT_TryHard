#include <Windows.h>
#include <stdio.h>
#include "WindowCodes.h"
#include "Assets.h"
#include "Clipboard.h"
#include "Tray.h"

#define CLASSNAME L"CCrune Class"
#define WINDOWNAME L"CCrune Window"
#define MAINWINDOWNAME L"CCrune Main"

HWND mainCC;

HWND initWindow(HINSTANCE hInst);
LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

_Use_decl_annotations_ int WINAPI wWinMain(HINSTANCE hInst, HINSTANCE hInstPrev, PWSTR cmdline, int cmdshow) {
	UNREFERENCED_PARAMETER(hInstPrev);
	UNREFERENCED_PARAMETER(cmdline);

	HWND cchWnd = FindWindow(CLASSNAME, WINDOWNAME);
	if (cchWnd != NULL) {
		PostMessage(cchWnd, APP_WC_SYSTEMTRAY, NULL, NULL);
		CloseHandle(cchWnd);
		return 0;
	}

	cchWnd = initWindow(hInst);
	
	if (!cchWnd) return 1;

	CCruneAssets::load(cchWnd);
	SetLayeredWindowAttributes(cchWnd, RGB(255, 93, 0), 255, LWA_ALPHA | LWA_COLORKEY);

	if (!initClipboard(cchWnd)) {
		return 3;
	}
	
	addTray(hInst, mainCC);
	if (!wcscmp(cmdline, L"--minimized")) {
		showTray();
	}
	else {
		ShowWindow(mainCC, cmdshow);
	}

	MSG uMsg;

	while (GetMessage(&uMsg, NULL, NULL, NULL)) {
		TranslateMessage(&uMsg);
		DispatchMessageW(&uMsg);
	}

	remTray();

	return 0;
}

UINT32 delay = -1;
int buttonOffset = 0;
COLORREF buttonColor = 0x00FFFFFF;

LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	switch (uMsg) {
	case APP_WC_SHOW:
		switch (wParam) {
		case APP_SHOW_COPY:
			CCruneAssets::Current = CCruneAssets::Copy;
			break;
		case APP_SHOW_BANK:
			if (lParam < 0 || lParam > 8) return 0;
			CCruneAssets::Current = CCruneAssets::Banks[lParam];
			break;
		case APP_SHOW_EXPORT:
			CCruneAssets::Current = CCruneAssets::Export;
			break;
		case APP_SHOW_DELAY:
			CCruneAssets::Current = lParam ? CCruneAssets::Delay : CCruneAssets::Forward;
			break;
		case APP_SHOW_PAUSED:
			CCruneAssets::Current = lParam ? CCruneAssets::Pause : CCruneAssets::Play;
			break;
		default:
			return 0;
		}
		if (delay == -1) {
			ShowWindow(hWnd, SW_SHOW);
		}
		delay = 500;
		break;
	case APP_WC_SYSTEMTRAY:
		if (hideTray()) {
			ShowWindow(mainCC, SW_SHOW);
		}
		SetForegroundWindow(mainCC);
		break;
	case APP_TRAY:
		if (lParam == WM_LBUTTONDBLCLK) {
			hideTray();
			ShowWindow(mainCC, SW_SHOW);
		}
		else {
			return DefWindowProc(hWnd, uMsg, wParam, lParam);
		}
		break;
	case WM_MOUSEMOVE:
		if (hWnd == mainCC) {
			RECT client;
			GetClientRect(hWnd, &client);
			client.top = client.bottom - buttonOffset;
			client.left = (client.right / 2) - 65;

			POINT p;
			p.y = HIWORD(lParam);
			p.x = LOWORD(lParam);

			if (client.top <= p.y && p.y - 25 <= client.top && p.x >= client.left && p.x <= client.left + 137) {
				if (buttonColor == 0x00FFFFFF) {
					buttonColor = 0x0066FFFF;
					InvalidateRect(mainCC, NULL, TRUE);
				}
			}
			else {
				if (buttonColor == 0x0066FFFF) {
					buttonColor = 0x00FFFFFF;
					InvalidateRect(mainCC, NULL, TRUE);
				}
			}
			break;
		}
		return DefWindowProc(hWnd, uMsg, wParam, lParam);
	case WM_LBUTTONDOWN:
		if (hWnd == mainCC) {
			RECT client;
			GetClientRect(hWnd, &client);
			client.top = client.bottom - buttonOffset;
			client.left = (client.right / 2) - 65;

			POINT p;
			p.y = HIWORD(lParam);
			p.x = LOWORD(lParam);

			if (client.top <= p.y && p.y - 25 <= client.top && p.x >= client.left && p.x <= client.left + 137) {
				showTray();
				ShowWindow(mainCC, SW_HIDE);
				buttonColor = 0x00FFFFFF;
			}
			break;
		}
		return DefWindowProc(hWnd, uMsg, wParam, lParam);
	case WM_PAINT:
	{
		PAINTSTRUCT ps;

		if (hWnd == mainCC) {
			HDC hdc = BeginPaint(hWnd, &ps);
			HDC compatHdc = CreateCompatibleDC(hdc);
			RECT client;
			GetClientRect(hWnd, &client);

			DeleteObject(SelectObject(compatHdc, CCruneAssets::Main));
			StretchBlt(hdc, 0, 0, client.right, client.bottom, compatHdc, 0, 0, client.right, client.bottom, SRCCOPY);

			HFONT font = CreateFont(15, 7, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, NULL);
			HFONT oldFont = (HFONT)SelectObject(hdc, font);

			RECT controlOffset = client;
			controlOffset.top = 10;
			controlOffset.left = 10;
			controlOffset.bottom = 130;
			controlOffset.right = 305;

			HBRUSH rectBrush = (HBRUSH)GetStockObject(WHITE_BRUSH);
			FillRect(hdc, &controlOffset, rectBrush);
			DeleteObject(rectBrush);

			SetBkColor(hdc, 0x00FFFFFF);
			DrawTextA(hdc, "Copy:\nPaste:\nCancel Paste:\nIncrease Input Delay:\nDecrease Input Delay:\nSwitch Bank/Clipboard:\nExport Current Bank as file:\nPause / Unpause Clipboard:", 149, &controlOffset, NULL);
			controlOffset.left = 230;
			DrawTextA(hdc, "Ctrl - C\nCtrl - V\nEnd\nCtrl - Right\nCtrl - Left\nCtrl - [1-9]\nCtrl - \\\nCtrl - .", 77, &controlOffset, NULL);

			font = CreateFont(25, 10, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, NULL);
			DeleteObject(SelectObject(hdc, font));
			SetBkColor(hdc, buttonColor);
			buttonOffset = DrawTextA(hdc, " Hide to Tray ", 14, &client, DT_VCENTER | DT_CENTER | DT_SINGLELINE);

			DeleteDC(compatHdc);
			DeleteObject(SelectObject(hdc, oldFont));
			EndPaint(hWnd, &ps);
			return 0;
		}

		if (delay == 0) {
			ShowWindow(hWnd, SW_HIDE);
			delay--;
			return DefWindowProc(hWnd, uMsg, wParam, lParam);
		}
		else if (delay == -1) {
			return DefWindowProc(hWnd, uMsg, wParam, lParam);
		}

		SetLayeredWindowAttributes(hWnd, RGB(255, 93, 0), (delay > 255 ? 255 : delay), LWA_ALPHA | LWA_COLORKEY);
		HDC hdc = BeginPaint(hWnd, &ps);
		
		HDC tempDc = CreateCompatibleDC(hdc);
		DeleteObject(SelectObject(tempDc, CCruneAssets::Current));

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
	wc.hIcon = LoadIcon(hInst, MAKEINTRESOURCE(IDI_CCrune));

	if (!RegisterClass(&wc)) {
		return NULL;
	}

	mainCC = CreateWindowEx(NULL, CLASSNAME, MAINWINDOWNAME, WS_OVERLAPPEDWINDOW ^ WS_MAXIMIZEBOX ^ WS_THICKFRAME, CW_USEDEFAULT, CW_USEDEFAULT, 640, 360, NULL, NULL, hInst, NULL);

	HFONT font = CreateFont(25, 20, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, NULL);

	if (!mainCC || !font) {
		return NULL;
	}

	DWORD posOffset = GetSystemMetrics(SM_CYSCREEN) * 0.0278;
	return CreateWindowEx(WS_EX_NOACTIVATE | WS_EX_TOPMOST | WS_EX_LAYERED, CLASSNAME, WINDOWNAME, WS_POPUP, posOffset, GetSystemMetrics(SM_CYSCREEN) - posOffset - 60, 30, 30, NULL, NULL, hInst, NULL);
}