#ifndef BUSTO_HTTP_H
#define BUSTO_HTTP_H

#ifdef __cplusplus
extern "C" {
#endif

char *busto_http_get(const char *url);
void busto_http_cleanup(char *response);

#ifdef __cplusplus
}
#endif

#endif

