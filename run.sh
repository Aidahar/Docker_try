#!/bin/bash

export DOCKER_CONTENT_TRUST=1
gcc -o my_server my_server.c -lfcgi
spawn-fcgi -a 127.0.0.1 -p 8080 ./my_server
nginx -g "daemon off;"
