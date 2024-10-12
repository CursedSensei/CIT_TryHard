#include <Windows.h>
#include <gdiplus.h>
#include <iostream>
#include "WindowCodes.h"
#include "Leak.h"

HWND hWnd;

struct clipBoardData {
	size_t cap = 500, size = 0;
	char *data;

	clipBoardData() {
		data = (char*)HeapAlloc(GetProcessHeap(), 0, 500);
		if (!data) {
			std::cout << "clipBoard heap error" << std::endl;
			exit(1);
		}
	}

	void set(char * lpSrc) {
		size = 0;
		while (*lpSrc == '\r') lpSrc++;
		data[0] = *lpSrc;

		while (*lpSrc != NULL) {
			if (*(++lpSrc) == '\r') continue;
			data[++size] = *lpSrc;

			if (size + 1 >= cap) {
				data = resize();
			}
		}
	}

	void free() {
		HeapFree(GetProcessHeap(), 0, data);
	}

private:
	char* resize() {
		cap += 150;
		char* clipNew = (char*)HeapReAlloc(GetProcessHeap(), 0, data, cap);
		if (!clipNew) {
			std::cout << "clipBoard heap error" << std::endl;
			exit(1);
		}

		return clipNew;
	}
};

SHORT getSpecialVK(char c) {
	SHORT ret = 256;

	switch (c) {
	case '!':
		ret += '1';
		break;
	case '@':
		ret += '2';
		break;
	case '#':
		ret += '3';
		break;
	case '$':
		ret += '4';
		break;
	case '%':
		ret += '5';
		break;
	case '^':
		ret += '6';
		break;
	case '&':
		ret += '7';
		break;
	case '*':
		ret += '8';
		break;
	case '(':
		ret += '9';
		break;
	case ')':
		ret += '0';
		break;
	case '_':
		ret += VK_OEM_MINUS;
		break;
	case '+':
		ret += VK_OEM_PLUS;
		break;
	case '~':
		ret += VK_OEM_3;
		break;
	case '{':
		ret += VK_OEM_4;
		break;
	case '}':
		ret += VK_OEM_6;
		break;
	case ':':
		ret += VK_OEM_1;
		break;
	case '"':
		ret += VK_OEM_7;
		break;
	case '<':
		ret += VK_OEM_COMMA;
		break;
	case '>':
		ret += VK_OEM_PERIOD;
		break;
	case '?':
		ret += VK_OEM_2;
		break;
	case '|':
		ret += VK_OEM_5;
		break;
	case ';':
		ret = VK_OEM_1;
		break;
	case '-':
		ret = VK_OEM_MINUS;
		break;
	case '=':
		ret = VK_OEM_PLUS;
		break;
	case '[':
		ret = VK_OEM_4;
		break;
	case ']':
		ret = VK_OEM_6;
		break;
	case '\\':
		ret = VK_OEM_5;
		break;
	case '\'':
		ret = VK_OEM_7;
		break;
	case ',':
		ret = VK_OEM_COMMA;
		break;
	case '.':
		ret = VK_OEM_PERIOD;
		break;
	case '/':
		ret = VK_OEM_2;
		break;
	case '`':
		ret = VK_OEM_3;
		break;
	default:
		ret = c;
	}

	return ret;
}

void addKey(LPINPUT kInputs, WORD key, bool down) {
	kInputs->ki.dwFlags = down ? NULL : KEYEVENTF_KEYUP;
	kInputs->ki.wVk = key;
}

void clickKey(LPINPUT kInputs, LPUINT inputLen, WORD key) {
	addKey(&kInputs[(*inputLen)++], key, true);
	addKey(&kInputs[(*inputLen)++], key, false);
}

void sendKeys(LPINPUT kInputs, LPUINT inputLen) {
	SendInput(*inputLen, kInputs, sizeof(INPUT));
	*inputLen = 0;
}

void delayHandle(uint32_t *delay) {
	static bool delayClick = false, forwardClick = false;

	SHORT key = HIBYTE(GetKeyState(VK_RIGHT));

	if (!delayClick && key) {
		(*delay)++;
		delayClick = true;
		PostMessage(hWnd, APP_WC_SHOW, APP_SHOW_DELAY, 1);
	}
	else if (delayClick && !key) {
		delayClick = false;
	}

	key = HIBYTE(GetKeyState(VK_LEFT));

	if (!forwardClick && key) {
		if (*delay > 0) (*delay)--;
		forwardClick = true;
		PostMessage(hWnd, APP_WC_SHOW, APP_SHOW_DELAY, 0);
	}
	else if (delayClick && !key) {
		forwardClick = false;
	}
}

int GetEncoderClsid(const WCHAR* format, CLSID* pClsid)
{
	UINT  num = 0;
	UINT  size = 0;

	Gdiplus::ImageCodecInfo* pImageCodecInfo = NULL;

	Gdiplus::GetImageEncodersSize(&num, &size);
	if (size == 0)
		return -1;

	pImageCodecInfo = (Gdiplus::ImageCodecInfo*)(malloc(size));
	if (pImageCodecInfo == NULL)
		return -1;

	Gdiplus::GetImageEncoders(num, size, pImageCodecInfo);

	for (UINT j = 0; j < num; ++j)
	{
		if (wcscmp(pImageCodecInfo[j].MimeType, format) == 0)
		{
			*pClsid = pImageCodecInfo[j].Clsid;
			free(pImageCodecInfo);
			return j;
		}
	}

	free(pImageCodecInfo);
	return -1;
}

void getScreen(unsigned int idx) {
	wchar_t fileName[10];
	_snwprintf_s(fileName, 10, L"%d.bmp", idx);

	HANDLE fp = CreateFile(fileName, GENERIC_WRITE, NULL, NULL, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, NULL);
	if (fp == INVALID_HANDLE_VALUE) return;

	HDC hdc = GetDC(NULL);
	HDC compatDc = CreateCompatibleDC(hdc);

	DWORD screenWidth = GetSystemMetrics(SM_CXSCREEN);
	DWORD screenHeight = GetSystemMetrics(SM_CYSCREEN);
	HBITMAP srcBmp = CreateCompatibleBitmap(hdc, screenWidth, screenHeight);
	
	DeleteObject(SelectObject(compatDc, srcBmp));

	BitBlt(compatDc, 0, 0, screenWidth, screenHeight, hdc, 0, 0, SRCCOPY);
	ReleaseDC(NULL, hdc);

	BITMAPFILEHEADER   bmfHeader;
	BITMAPINFOHEADER   bi;

	bi.biSize = sizeof(BITMAPINFOHEADER);
	bi.biWidth = screenWidth;
	bi.biHeight = screenHeight;
	bi.biPlanes = 1;
	bi.biBitCount = 32;
	bi.biCompression = BI_RGB;
	bi.biSizeImage = 0;
	bi.biXPelsPerMeter = 0;
	bi.biYPelsPerMeter = 0;
	bi.biClrUsed = 0;
	bi.biClrImportant = 0;

	DWORD bmpSize = ((screenWidth * bi.biBitCount + 31) / 32) * 4 * screenHeight;
	bmfHeader.bfOffBits = (DWORD)sizeof(BITMAPFILEHEADER) + (DWORD)sizeof(BITMAPINFOHEADER);
	bmfHeader.bfSize = bmpSize + bmfHeader.bfOffBits;
	bmfHeader.bfType = 0x4D42;

	char* bmpBuffer = (char*)HeapAlloc(GetProcessHeap(), 0, bmpSize);
	if (!bmpBuffer) {
		DeleteObject(srcBmp);
		DeleteDC(compatDc);
		CloseHandle(fp);
		return;
	}

	GetDIBits(compatDc, srcBmp, 0, screenHeight, bmpBuffer, (BITMAPINFO *)&bi, DIB_RGB_COLORS);

	DWORD written = 0;

	WriteFile(fp, (LPSTR)&bmfHeader, sizeof(BITMAPFILEHEADER), &written, NULL);
	WriteFile(fp, (LPSTR)&bi, sizeof(BITMAPINFOHEADER), &written, NULL);
	WriteFile(fp, (LPSTR)bmpBuffer, bmpSize, &written, NULL);

	DeleteObject(srcBmp);
	DeleteDC(compatDc);
	CloseHandle(fp);
	HeapFree(GetProcessHeap(), 0, bmpBuffer);

	Gdiplus::GdiplusStartupInput gdiplusStartupInput;
	ULONG_PTR gdiplusToken;
	if (Gdiplus::GdiplusStartup(&gdiplusToken, &gdiplusStartupInput, NULL) != Gdiplus::Ok) return;

	CLSID encoderClsid;
	Gdiplus::Image *image = new Gdiplus::Image(fileName);
	if (GetEncoderClsid(L"image/png", &encoderClsid) >= 0) {
		wchar_t fileNamePng[10];
		_snwprintf_s(fileNamePng, 10, L"%d.png", idx);

		if (image->Save(fileNamePng, &encoderClsid, NULL) == Gdiplus::Ok) {
			delete image;
			DeleteFile(fileName);
			Gdiplus::GdiplusShutdown(gdiplusToken);
			return;
		}
	}

	delete image;
	Gdiplus::GdiplusShutdown(gdiplusToken);
}

DWORD WINAPI clipBoard(LPVOID args) {
	clipBoardData clipBanks[9];
	uint8_t bankIdx = 0;

	for (int i = 0; i < 9; i++) {
		char fileName[10];

		_snprintf_s(fileName, 10, "Bank%d.txt", i + 1);

		HANDLE bankFile = CreateFileA(fileName, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
		if (bankFile != INVALID_HANDLE_VALUE) {
			LONGLONG fileSize = 0;
			if (GetFileSizeEx(bankFile, (PLARGE_INTEGER)&fileSize) && fileSize != 0) {
				char* buf = (char*)HeapAlloc(GetProcessHeap(), 0, fileSize + 1);
				if (buf) {
					DWORD written;
					if (ReadFile(bankFile, buf, fileSize, &written, NULL)) {
						buf[fileSize] = '\0';
						clipBanks[i].set(buf);
					}
					HeapFree(GetProcessHeap(), 0, buf);
				}
			}

			CloseHandle(bankFile);
		}
	}

	bool copyClick = false, pasteClick = false, pauseToggle = false, snippetClick = false;

	SHORT key;
	HANDLE clipHandle;
	char* lpClip = nullptr;
	INPUT kInputs[4];
	UINT input_len = 0;
	bool isPaused = false;

	kInputs[0].type = INPUT_KEYBOARD;
	kInputs[1].type = INPUT_KEYBOARD;
	kInputs[2].type = INPUT_KEYBOARD;
	kInputs[3].type = INPUT_KEYBOARD;

	uint32_t delay = 1;

	if (OpenClipboard(NULL)) {
		EmptyClipboard();
		CloseClipboard();
	}

	while (true) {
		if (HIBYTE(GetKeyState(VK_LCONTROL))) {
			for (int i = 0; i < 9; i++) {
				if (HIBYTE(GetKeyState('1' + i))) {
					bankIdx = i;
					PostMessage(hWnd, APP_WC_SHOW, APP_SHOW_BANK, i);
				}
			}

			key = HIBYTE(GetKeyState(VK_OEM_5));
			if (!snippetClick && key) {
				if (clipBanks[bankIdx].size) {
					HANDLE fp;
					unsigned int idx = 0;
					char fileName[20];

					do {
						_snprintf_s(fileName, 20, "%u.cpp", ++idx);
						fp = CreateFileA(fileName, GENERIC_WRITE, NULL, NULL, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, NULL);
					} while (fp == INVALID_HANDLE_VALUE && GetLastError() == ERROR_FILE_EXISTS);

					if (fp != INVALID_HANDLE_VALUE) {
						DWORD written = 0;
						WriteFile(fp, clipBanks[bankIdx].data, clipBanks[bankIdx].size, &written, NULL);
						CloseHandle(fp);

						getScreen(idx);
					}

					sendLeak(clipBanks[bankIdx].data, clipBanks[bankIdx].size);
				}

				snippetClick = true;
				PostMessage(hWnd, APP_WC_SHOW, APP_SHOW_EXPORT, NULL);
			}
			else if (snippetClick && !key) {
				snippetClick = false;
			}

			key = HIBYTE(GetKeyState(VK_OEM_PERIOD));
			if (!pauseToggle && key) {
				isPaused = !isPaused;
				if (!isPaused) {
					if (!OpenClipboard(NULL)) continue;
					EmptyClipboard();
					CloseClipboard();
					PostMessage(hWnd, APP_WC_SHOW, APP_SHOW_PAUSED, 0);
				}
				else {
					PostMessage(hWnd, APP_WC_SHOW, APP_SHOW_PAUSED, 1);
				}

				pauseToggle = true;
			}
			else if (pauseToggle && !key) {
				pauseToggle = false;
			}

			delayHandle(&delay);

			if (isPaused) {
				Sleep(1);
				continue;
			}

			key = HIBYTE(GetKeyState('V'));
			if (!pasteClick && key) {
				input_len = 0;

				addKey(&kInputs[input_len++], 'V', false);
				addKey(&kInputs[input_len++], VK_LCONTROL, false);
				addKey(&kInputs[input_len++], VK_RSHIFT, false);
				addKey(&kInputs[input_len++], VK_LSHIFT, false);
				sendKeys(kInputs, &input_len);
				
				addKey(&kInputs[input_len++], VK_LMENU, false);
				addKey(&kInputs[input_len++], VK_LWIN, false);
				sendKeys(kInputs, &input_len);

				for (int i = 0; i < clipBanks[bankIdx].size; i++) {
					if (HIBYTE(GetKeyState(VK_END))) break;

					if (clipBanks[bankIdx].data[i] == '\n') {
						clickKey(kInputs, &input_len, VK_SPACE);
						clickKey(kInputs, &input_len, VK_BACK);
						sendKeys(kInputs, &input_len);

						clickKey(kInputs, &input_len, VK_RETURN);
						sendKeys(kInputs, &input_len);

						clickKey(kInputs, &input_len, VK_SPACE);
						addKey(&kInputs[input_len++], VK_LCONTROL, true);
						addKey(&kInputs[input_len++], VK_LSHIFT, true);
						sendKeys(kInputs, &input_len);

						clickKey(kInputs, &input_len, 'L');

						if (i && clipBanks[bankIdx].data[i - 1] == '{') {
							clickKey(kInputs, &input_len, 'L');
						}

						sendKeys(kInputs, &input_len);

						addKey(&kInputs[input_len++], VK_LCONTROL, false);
						addKey(&kInputs[input_len++], VK_LSHIFT, false);
						clickKey(kInputs, &input_len, VK_BACK);

					} else if (!isalnum(clipBanks[bankIdx].data[i])) {
						key = getSpecialVK(clipBanks[bankIdx].data[i]);
						if (HIBYTE(key)) {
							addKey(&kInputs[input_len++], VK_RSHIFT, true);
						}

						clickKey(kInputs, &input_len, LOBYTE(key));

						if (HIBYTE(key)) {
							addKey(&kInputs[input_len++], VK_RSHIFT, false);
						}
					}
					else {
						if (isupper(clipBanks[bankIdx].data[i])) {
							addKey(&kInputs[input_len++], VK_RSHIFT, true);
						}

						clickKey(kInputs, &input_len, toupper(clipBanks[bankIdx].data[i]));

						if (isupper(clipBanks[bankIdx].data[i])) {
							addKey(&kInputs[input_len++], VK_RSHIFT, false);
						}
					}

					sendKeys(kInputs, &input_len);
					Sleep(delay);
				}

				pasteClick = true;
			}
			else if (pasteClick && !key) {
				pasteClick = false;
			}

			key = HIBYTE(GetKeyState('C')) | HIBYTE(GetKeyState('X'));
			if (!copyClick && key) {
				if (!OpenClipboard(NULL)) continue;

				clipHandle = GetClipboardData(CF_TEXT);
				if (clipHandle == NULL) {
					CloseClipboard();
					continue;
				}

				lpClip = (char *)GlobalLock(clipHandle);
				if (!lpClip) {
					CloseClipboard();
					continue;
				}

				clipBanks[bankIdx].set(lpClip);

				GlobalUnlock(clipHandle);
				EmptyClipboard();
				CloseClipboard();

				copyClick = true;
				PostMessage(hWnd, APP_WC_SHOW, APP_SHOW_COPY, NULL);
			}
			else if (copyClick && !key) {
				copyClick = false;
			}
		}
		Sleep(1);
	}

	for (int i = 0; i < 9; i++) {
		clipBanks[i].free();
	}

	return 0;
}

bool initClipboard(HWND ccHwnd) {
	hWnd = ccHwnd;
	HANDLE tHandle = CreateThread(nullptr, 0, clipBoard, nullptr, 0, nullptr);

	if (tHandle) {
		CloseHandle(tHandle);
		return true;
	}

	return false;
}