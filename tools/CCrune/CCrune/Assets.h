#pragma once

#include "resource.h"

namespace CCruneAssets {
	HBITMAP Current = NULL;

	HBITMAP Copy = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_COPY), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Delay = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_DELAY), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Forward = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_FORWARD), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Play = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_PLAY), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Pause = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_PAUSE), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Export = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_EXPORT), IMAGE_BITMAP, 30, 30, LR_DEFAULTCOLOR);
	HBITMAP Main = (HBITMAP)LoadImage(GetModuleHandle(NULL), MAKEINTRESOURCE(IDB_MAIN), IMAGE_BITMAP, 640, 360, LR_DEFAULTCOLOR);

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