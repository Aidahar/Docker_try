## Part 1. Готовый докер

* ### Взять официальный докер образ с **nginx** и выкачать его при помощи `docker pull`

![Docker_pull](01/img/docker_pull.png)

* ### Проверить наличие докер образа через `docker images`

![Docker_images](01/img/docker_images.png)

* ### Запустить докер образ через `docker run -d [image_id|repository]`
* ### Проверить, что образ запустился через `docker ps`

![Docker_run](01/img/docker_run_ps.png)

* ### Посмотреть информацию о контейнере через `docker inspect [container_id|container_name]`
  ### **Ip контейнера**

![Docker_inspect](01/img/container_ip.png)

  ### **Размер контейнера**

![Docker_inspect](01/img/size.png)

  ### **Cписок замапленных портов**

![Docker_inspect](01/img/port.png)

* ### Остановить докер образ через `docker stop [container_id|container_name]`
  ### Проверить, что образ остановился через `docker ps`

![Docker_stop](01/img/docker_stop.png)

* ### Запустить докер с портами 80 и 443 в контейнере, замапленными на такие же порты на локальной машине, через команду *run*

![Docker_port](01/img/Docker_port_80_443.png)

* ### Проверить, что в браузере по адресу *localhost:80* доступна стартовая страница **nginx**

![Localhost](01/img/docker_port_80.png)

* ### Перезапустить докер контейнер через `docker restart [container_id|container_name]`
  ### Проверить любым способом, что контейнер запустился

![Docker_restart](01/img/docker_restart.png)

## Part 2. Операции с контейнером

* ### Прочитать конфигурационный файл *nginx.conf* внутри докер контейнера через команду *exec*

![nginx.conf_exec](02/img/nginx_conf_exec.png)

* ### Создать на локальной машине файл *nginx.conf*
  ### Настроить в нем по пути */status* отдачу страницы статуса сервера **nginx**
  ### Скопировать созданный файл *nginx.conf* внутрь докер образа через команду `docker cp`
  ### Перезапустить **nginx** внутри докер образа через команду *exec*
  ### Проверить, что по адресу *localhost:80/status* отдается страничка со статусом сервера **nginx**

![nginx_conf_local](02/img/nginx_conf_docker.png)

![nginx_conf_cp](02/img/nginx_conf_docker_cp_restart.png)

![nginx_response_status](02/img/nginx_conf_docker_status_site.png)

* ### Экспортировать контейнер в файл *container.tar* через команду *export*
  ### Остановить контейнер

![nginx_export-stop](02/img/nginx_export_stop.png)

* ### Удалить образ через `docker rmi [image_id|repository]`, не удаляя перед этим контейнеры
  ### Удалить остановленный контейнер

![nginx_delete](02/img/nginx_delete.png)

* ### Импортировать контейнер обратно через команду *import*
  ### Запустить импортированный контейнер
  ### Проверить, что по адресу *localhost:80/status* отдается страничка со статусом сервера **nginx**

![nginx_import](02/img/nginx_import.png)

![nginx_import_run](02/img/nginx_import_run_status.png)

## Part 3. Мини веб-сервер

* ### Написать мини сервер на **C** и **FastCgi**, который будет возвращать простейшую страничку с надписью `Hello World!`

  ![my_server](03/img/my_server.png)

*  ### Запустить написанный мини сервер через *spawn-fcgi* на порту 8080

  ![docker_run](03/img/docker_run_81.png)
  
  ![my_server_port](03/img/server%20in%20docker.png)
  
  ![docker_login](03/img/docker_login.png)
  
  ![docker_install](03/img/docker_install_spawn.png)
  
  ![server_run](03/img/my_server_run.png)
  
*  ### Написать свой *nginx.conf*, который будет проксировать все запросы с 81 порта на *127.0.0.1:8080*

  ![nginx_config](03/img/nginx_config.png)

*  ### Проверить, что в браузере по *localhost:81* отдается написанная вами страничка

  ![localhost:81](03/img/localhost_81.png)

*  ### Положить файл *nginx.conf* по пути *./nginx/nginx.conf* (это понадобится позже)

## Part 4. Свой докер

* ### Написать свой докер образ, который:
  ### 1) собирает исходники мини сервера на FastCgi из [Части 3](#part-3-мини-веб-сервер)
  ### 2) запускает его на 8080 порту
  ### 3) копирует внутрь образа написанный *./nginx/nginx.conf*
  ### 4) запускает **nginx**.