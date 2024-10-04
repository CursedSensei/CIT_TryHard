#include <dpp/dpp.h>

#define PTHREAD_FUNCTION void *

char **webhooks = nullptr;
uint32_t numberOfWebhooks = 0;

void initWebhook() {
    FILE * fp = fopen("webhookUrl.txt", "r");
    if (fp == nullptr) return;

    fseek(fp, 0, SEEK_END);

    size_t size = ftell(fp);
    rewind(fp);

    char *fileData = (char *)malloc(size + 1);
    if (fileData == nullptr) {
        fclose(fp);
        return;
    }

    fread(&fileData, 1, size, fp);
    fclose(fp);
    fileData[size] = '\0';

    webhooks = (char **)malloc(sizeof(char *) * 50);
    if (webhooks == nullptr) {
        free(fileData);
        return;
    }

    char *offSet = fileData;
    for (int i = 0; i < size; i++) {
        if (fileData[i] == '\n') {
            fileData[i] = '\0';
            if (fileData[i + 1] != '\0') {
                if (numberOfWebhooks % 50 == 0) {
                    char ** newBuf = (char **)realloc(webhooks, sizeof(char *) * (numberOfWebhooks + 50));
                    if (newBuf == nullptr) {
                        free(fileData);
                        free(webhooks);
                        webhooks = nullptr;
                        numberOfWebhooks = 0;
                        return;
                    }
                    webhooks = newBuf;
                }
                webhooks[numberOfWebhooks++] = offSet;
                offSet = fileData + i + 1;
            }
        }
    }

    char ** newBuf = (char **)realloc(webhooks, sizeof(char *) * numberOfWebhooks);
    if (newBuf == nullptr) {
        free(fileData);
        free(webhooks);
        webhooks = nullptr;
        numberOfWebhooks = 0;
        return;
    }
    webhooks = newBuf;
}

void cleanupWebhook() {
    if (webhooks == nullptr) return;
    free(webhooks[0]);
    free(webhooks);
    webhooks = nullptr;
    numberOfWebhooks = 0;
}

PTHREAD_FUNCTION webhookThread(void *args) {
    char *dataLeak = (char *)args;

    // to send
}