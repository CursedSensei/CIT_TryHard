#include <dpp/webhook.h>

#define PTHREAD_FUNCTION void *

char **webhooks = nullptr;
uint32_t numberOfWebhooks = 0;

void initWebhook() {
    FILE * fp = fopen("webhookUrl.txt", "r");
    if (fp == nullptr) return;

    fseek(fp, 0, SEEK_END);

    size_t size = ftell(fp);
    rewind(fp);

    char *fileData = (char *)malloc(size);

    fread(&fileData, 1, size, fp);
    fclose(fp);

    webhooks = (char **)malloc(sizeof(char *) * 50);
    if (webhooks == nullptr) {
        free(fileData);
        return;
    }

    char *offSet = fileData;
    for (int i = 0; i < size; i++) {
        if (fileData[i] == '\n') {
            if (numberOfWebhooks % 50 == 0) {
                char ** newBuf = (char **)realloc(webhooks, sizeof(char *) * (numberOfWebhooks + 50));
                if (newBuf == nullptr) {
                    free(fileData);
                    free(webhooks);
                    webhooks = nullptr;
                    numberOfWebhooks = 0;
                    return;
                }
            }
            webhooks[numberOfWebhooks++] = offSet;
            offSet = fileData + i;
        }
    }
}

void cleanupWebhook() {
    if (webhooks == nullptr) return;

    for (int i = 0; i < numberOfWebhooks; i++) {
        free(webhooks[i]);
    }

    free(webhooks);
    webhooks = nullptr;
    numberOfWebhooks = 0;
}

PTHREAD_FUNCTION webhookThread(void *args) {
    char *dataLeak = (char *)args;
}