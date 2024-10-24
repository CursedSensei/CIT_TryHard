#include <dpp/dpp.h>
#include <time.h>
#include <iostream>

#define PTHREAD_FUNCTION void *

std::vector<dpp::webhook> webhooks;

dpp::cluster bot("");

void initWebhook() {
    FILE * fp = fopen("webhookUrl.txt", "r");
    if (fp == nullptr) return;

    fseek(fp, 0, SEEK_END);

    size_t size = ftell(fp);
    rewind(fp);

    char *fileData = (char *)malloc(++size);
    if (fileData == nullptr) {
        fclose(fp);
        return;
    }

    fread(fileData, 1, size, fp);
    fclose(fp);
    fileData[size - 1] = '\n';

    char *offSet = fileData;
    for (int i = 0; i < size; i++) {
        if (fileData[i] == '\n') {
            if ((i && fileData[i - 1] == '\0') || i == 0) {
                offSet = fileData + i + 1;
                continue;
            }
            fileData[i] = '\0';
            webhooks.push_back(dpp::webhook(offSet));
            offSet = fileData + i + 1;
        }
    }

    free(fileData);
}

void webhookSend(char *dataLeak, std::string *visualCtx, char *visualCtxName) {
    time_t thisTime;
    struct tm timeData;
    dpp::message leakMessage;
    char caption[100];

    time(&thisTime);
    localtime_r(&thisTime, &timeData);

    if (timeData.tm_wday == 1) {
        strftime(caption, 100, "%A, %B %d, %Y\nF1 Java Mondae", &timeData)
        leakMessage = dpp::message(caption).add_file("Snippet.java", dataLeak);
    } else if (timeData.tm_wday == 2) {
        strftime(caption, 100, "%A, %B %d, %Y\nF1 C++ Tuesdae", &timeData)
        leakMessage = dpp::message(caption).add_file("Snippet.cpp", dataLeak);
    } else {
        strftime(caption, 100, "%A, %B %d, %Y\nF1 Assignment", &timeData)
        leakMessage = dpp::message(caption).add_file("Snippet.text", dataLeak);
    }
 
    if (visualCtx != nullptr) {
        leakMessage.add_file(visualCtxName, visualCtx);
    }

    for (int i = webhooks.size() - 1; i >= 0; i--) {
        bot.execute_webhook_sync(webhooks[i], leakMessage);
    }
}
