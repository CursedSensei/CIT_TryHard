#pragma once
#include <string_view>
#include <iostream>

void initWebhook();
void webhookSend(char *dataLeak, std::string_view visualCtx, char *visualCtxName);
