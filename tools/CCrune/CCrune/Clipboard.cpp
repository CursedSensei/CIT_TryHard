#include <Windows.h>
#include <iostream>

bool noTab;

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
		data[0] = *lpSrc;
		while (*lpSrc != NULL) {
			data[++size] = *(++lpSrc);

			if (size + 1 >= cap) {
				cap += 150;
				char* clipNew = (char*)HeapReAlloc(GetProcessHeap(), 0, data, cap);
				if (!clipNew) {
					std::cout << "clipBoard heap error" << std::endl;
					exit(1);
				}

				data = clipNew;
			}
		}
	}

	void free() {
		HeapFree(GetProcessHeap(), 0, data);
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
	case '\n':
		ret = VK_RETURN;
		break;
	default:
		ret = c;
	}

	return ret;
}

DWORD WINAPI clipBoard(LPVOID args) {
	clipBoardData clipBanks[9];
	uint8_t bankIdx = 0;

	bool copyClick = false, pasteClick = false, tabToggle = false;

	SHORT key;
	HANDLE clipHandle;
	char* lpClip = nullptr;
	INPUT kInputs[4];
	UINT input_len = 0;

	while (true) {
		if (HIBYTE(GetKeyState(VK_LCONTROL))) {
			for (int i = 0; i < 9; i++) {
				if (HIBYTE(GetKeyState('1' + i))) {
					bankIdx = i;
				}
			}

			key = HIBYTE(GetKeyState('0'));

			if (!tabToggle && key) {
				noTab = !noTab;
			}
			else if (tabToggle && !key) {
				tabToggle = false;
			}

			key = HIBYTE(GetKeyState('V'));

			if (!pasteClick && key) {
				ZeroMemory(kInputs, sizeof(kInputs));
				input_len = 0;

				kInputs[input_len].type = INPUT_KEYBOARD;
				kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
				kInputs[input_len++].ki.wVk = 'V';

				kInputs[input_len].type = INPUT_KEYBOARD;
				kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
				kInputs[input_len++].ki.wVk = VK_LCONTROL;

				kInputs[input_len].type = INPUT_KEYBOARD;
				kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
				kInputs[input_len++].ki.wVk = VK_RSHIFT;

				kInputs[input_len].type = INPUT_KEYBOARD;
				kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
				kInputs[input_len++].ki.wVk = VK_LSHIFT;

				SendInput(input_len, kInputs, sizeof(INPUT));
				input_len = 0;
				ZeroMemory(kInputs, sizeof(kInputs));

				kInputs[input_len].type = INPUT_KEYBOARD;
				kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
				kInputs[input_len++].ki.wVk = VK_LMENU;

				kInputs[input_len].type = INPUT_KEYBOARD;
				kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
				kInputs[input_len++].ki.wVk = VK_LWIN;

				SendInput(input_len, kInputs, sizeof(INPUT));
				input_len = 0;
				ZeroMemory(kInputs, sizeof(INPUT) * 2);
				bool spaced = false, spacedTab = false;

				for (int i = 0; i < clipBanks[bankIdx].size; i++) {
					if (HIBYTE(GetKeyState(VK_END))) break;
					if (!isalnum(clipBanks[bankIdx].data[i])) {
						if (clipBanks[bankIdx].data[i] == '\r' || (noTab ? clipBanks[bankIdx].data[i] == '\t' : false)) continue;

						if (noTab && clipBanks[bankIdx].data[i] == ' ') {
							if (spacedTab) continue;
							else if (spaced) {
								spacedTab = true;

								kInputs[input_len].type = INPUT_KEYBOARD;
								kInputs[input_len++].ki.wVk = VK_BACK;

								kInputs[input_len].type = INPUT_KEYBOARD;
								kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
								kInputs[input_len++].ki.wVk = VK_BACK;

								SendInput(input_len, kInputs, sizeof(INPUT));
								ZeroMemory(kInputs, sizeof(INPUT) * input_len);
								input_len = 0;

								continue;
							}
							spaced = true;
						}
						else {
							spacedTab = false;
							spaced = false;
						}

						key = getSpecialVK(clipBanks[bankIdx].data[i]);

						if (HIBYTE(key)) {
							kInputs[input_len].type = INPUT_KEYBOARD;
							kInputs[input_len++].ki.wVk = VK_RSHIFT;
						}

						kInputs[input_len].type = INPUT_KEYBOARD;
						kInputs[input_len++].ki.wVk = LOBYTE(key);

						kInputs[input_len].type = INPUT_KEYBOARD;
						kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
						kInputs[input_len++].ki.wVk = LOBYTE(key);

						if (HIBYTE(key)) {
							kInputs[input_len].type = INPUT_KEYBOARD;
							kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
							kInputs[input_len++].ki.wVk = VK_RSHIFT;
						}
					}
					else {
						if (isupper(clipBanks[bankIdx].data[i])) {
							kInputs[input_len].type = INPUT_KEYBOARD;
							kInputs[input_len++].ki.wVk = VK_RSHIFT;
						}

						kInputs[input_len].type = INPUT_KEYBOARD;
						kInputs[input_len++].ki.wVk = toupper(clipBanks[bankIdx].data[i]);

						kInputs[input_len].type = INPUT_KEYBOARD;
						kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
						kInputs[input_len++].ki.wVk = toupper(clipBanks[bankIdx].data[i]);

						if (isupper(clipBanks[bankIdx].data[i])) {
							kInputs[input_len].type = INPUT_KEYBOARD;
							kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
							kInputs[input_len++].ki.wVk = VK_RSHIFT;
						}
					}

					SendInput(input_len, kInputs, sizeof(INPUT));
					ZeroMemory(kInputs, sizeof(INPUT) * input_len);
					input_len = 0;
					Sleep(1);
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

bool initClipboard(bool silenceTab) {
	noTab = silenceTab;
	HANDLE tHandle = CreateThread(nullptr, 0, clipBoard, nullptr, 0, nullptr);

	if (tHandle) {
		CloseHandle(tHandle);
		return true;
	}

	return false;
}

void setTab(bool silenceTab) {
	noTab = silenceTab;
}