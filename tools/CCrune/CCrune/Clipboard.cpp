#include <Windows.h>
#include <iostream>

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
		ret += '=';
		break;
	case '~':
		ret += '`';
		break;
	case '{':
		ret += '[';
		break;
	case '}':
		ret += ']';
		break;
	case ':':
		ret += VK_OEM_1;
		break;
	case '"':
		ret += '\'';
		break;
	case '<':
		ret += ',';
		break;
	case '>':
		ret += '.';
		break;
	case '?':
		ret += '/';
		break;
	case '|':
		ret += '\\';
		break;
	case ';':
		ret = VK_OEM_1;
		break;
	case '-':
		ret = VK_OEM_MINUS;
		break;
	default:
		ret = c;
	}

	return ret;
}

DWORD WINAPI clipBoard(LPVOID args) {
	UINT32 cap = 500;
	UINT32 size = 0;
	char* clipData = (char*)HeapAlloc(GetProcessHeap(), 0, 500 * sizeof(char));
	if (!clipData) {
		std::cout << "clipBoard heap error" << std::endl;
		exit(1);
		return 1;
	}

	bool copyClick = false, pasteClick = false;

	SHORT key;
	HANDLE clipHandle;
	char* lpClip = nullptr;
	while (true) {
		if (HIBYTE(GetKeyState(VK_LCONTROL))) {
			std::cout << "text" << std::endl;
			key = HIBYTE(GetKeyState('V'));

			if (!pasteClick && key) {
				LPINPUT kInputs = (LPINPUT)HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, (size * 4 + 5) * sizeof(INPUT));
				if (!kInputs) {
					std::cout << "clipBoard paste heap error" << std::endl;
					exit(1);
					return 1;
				}

				UINT input_len = 0;

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

				kInputs[input_len].type = INPUT_KEYBOARD;
				kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
				kInputs[input_len++].ki.wVk = VK_LMENU;

				for (int i = 0; i < size; i++) {
					if (!isalnum(clipData[i])) {
						key = getSpecialVK(clipData[i]);

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

						continue;
					}

					if (isupper(clipData[i]) ) {
						kInputs[input_len].type = INPUT_KEYBOARD;
						kInputs[input_len++].ki.wVk = VK_RSHIFT;
					}

					kInputs[input_len].type = INPUT_KEYBOARD;
					kInputs[input_len++].ki.wVk = toupper(clipData[i]);

					kInputs[input_len].type = INPUT_KEYBOARD;
					kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
					kInputs[input_len++].ki.wVk = toupper(clipData[i]);

					if (isupper(clipData[i])) {
						kInputs[input_len].type = INPUT_KEYBOARD;
						kInputs[input_len].ki.dwFlags = KEYEVENTF_KEYUP;
						kInputs[input_len++].ki.wVk = VK_RSHIFT;
					}
				}

				SendInput(input_len, kInputs, sizeof(INPUT));

				HeapFree(GetProcessHeap(), 0, kInputs);
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

				size = 0;
				clipData[0] = *lpClip;
				while (*lpClip != NULL) {
					clipData[++size] = *(++lpClip);

					if (size + 1 >= cap) {
						cap += 150;
						char* clipNew = (char*)HeapReAlloc(GetProcessHeap(), 0, clipData, cap);
						if (!clipNew) {
							std::cout << "clipBoard heap error" << std::endl;
							exit(1);
							return 1;
						}

						clipData = clipNew;
					}
				}

				GlobalUnlock(clipHandle);
				EmptyClipboard();
				CloseClipboard();

				copyClick = true;
			}
			else if (copyClick && !key) {
				copyClick = false;
			}
		}
		Sleep(3);
	}

	HeapFree(GetProcessHeap(), NULL, clipData);
	return 0;
}

bool initClipboard() {
	HANDLE tHandle = CreateThread(nullptr, 0, clipBoard, nullptr, 0, nullptr);

	if (tHandle) {
		CloseHandle(tHandle);
		system("pause");
		return true;
	}

	return false;
}