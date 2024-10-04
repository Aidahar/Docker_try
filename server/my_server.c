#include "my_server.h"

void main(void) {
  while (FCGI_Accept() >= 0) {
    printf(
        "Content-type: text/html\r\n"
        "\r\n"
        "<html>\n"
        "<title>Hello FCGI!</title>\n"
        "<h1>Hello World!</h1>\n"
        "<body>Hello World!</body>\n"
        "</html>\n");
  }
}