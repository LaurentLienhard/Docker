# How to run FusionSuite (DEV) on docker

## 01-Install

Clone repository on your computer

```git clone https://github.com/LaurentLienhard/Docker.git C:\MyDev\Test```

Go to directory FS-MariaDB

```cd C:\MyDev\Test\FusionSuite\FS-MariaDB\```

and run

```docker-compose up -d```

```console
Creating network "fs-mariadb_default" with the default driver
Pulling backend-mariadb (laurentlienhard/fusionsuite-backend:DEV)...
DEV: Pulling from laurentlienhard/fusionsuite-backend
0e29546d541c: Already exists
7f2ef7e1de61: Pull complete
635bde613c0a: Pull complete
2ea2d30ff986: Pull complete
aa79d19084c4: Pull complete
8736ad6ac6f1: Pull complete
7fe5f9928f35: Pull complete
241535c7a530: Pull complete
1d95270c6d67: Pull complete
cedee71c7526: Pull complete
71e00cf5fc33: Pull complete
Digest: sha256:cc194a12d9b8354269998e0d66d1791f1db4c2fd297b82807eb5568d1aef89e0
Status: Downloaded newer image for laurentlienhard/fusionsuite-backend:DEV
Pulling frontend (laurentlienhard/fusionsuite-frontend:DEV)...
DEV: Pulling from laurentlienhard/fusionsuite-frontend
0e29546d541c: Already exists
403306c2854f: Pull complete
a6f4f13f8998: Pull complete
8c1025b4f0ff: Pull complete
Digest: sha256:d3fb8a9a161e0d921087b26876659c5f21858ecbbecdeeb4e79be1c0abaf2d0e
Status: Downloaded newer image for laurentlienhard/fusionsuite-frontend:DEV
Creating fs-mariadb_backend-mariadb_1 ... done
Creating fs-mariadb_frontend_1        ... done
```

## 02-Check

if you run ```docker ps``` you should see something like this

```text
CONTAINER ID        IMAGE                                      COMMAND             CREATED             STATUS              PORTS                  NAMES
100c54334138        laurentlienhard/fusionsuite-frontend:DEV   "./entrypoint.sh"   8 seconds ago       Up 7 seconds        0.0.0.0:8080->80/tcp   fs-mariadb_frontend_1
f9422fb50171        laurentlienhard/fusionsuite-backend:DEV    "./entrypoint.sh"   8 seconds ago       Up 7 seconds        0.0.0.0:80->80/tcp     fs-mariadb_backend-mariadb_1
 ```

 ### _The container with name ```fs-mariadb_backend-mariadb_1``` is running ?_

 Open a browser en try : ```http://localhost/ping```

 The response should be ```pong```

 Open a browser en try : ```http://localhost/v1/status```

 The response should be ```{"connections":{"database":true}}```

 Congratulation FusionSuite backend is running !
 
 ### _The container with name ```fs-mariadb_frontend_1``` is running ?_
  
 Open a browser en try : ```http://localhost:8080/```
 
 the FusionSuite home page should appear
 
 Congratulation FusionSuite frontend is running !
