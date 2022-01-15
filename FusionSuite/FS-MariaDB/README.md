# COMMENT

## How to run FusionSuite (DEV) on docker

Clone repository on your computer

```git clone https://github.com/LaurentLienhard/Docker.git C:\MyDev\Docker\FusionSuite\test\```

Go to directory FS-MariaDB

```cd .\FusionSuite\FS-MariaDB\```

and run 

```docker-compose up -d```

## Update frontend docker image

* run docker image from hub

```docker run --name fusion-backend -p 80:80 -it laurentlienhard/fusionsuite-backend:DEV```

```
Unable to find image 'laurentlienhard/fusionsuite-backend:DEV' locally
DEV: Pulling from laurentlienhard/fusionsuite-backend
0e29546d541c: Already exists
7f2ef7e1de61: Downloading [=========================>                         ]  80.54MB/159.8MB
635bde613c0a: Download complete
2ea2d30ff986: Download complete
```

* in docker image 

```cd /var/www/fusionsuite/backend```

```git pull```

```
hint: Pulling without specifying how to reconcile divergent branches is
hint: discouraged. You can squelch this message by running one of the following
hint: commands sometime before your next pull:
hint:
hint:   git config pull.rebase false  # merge (the default strategy)
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint:
hint: You can replace "git config" with "git config --global" to set a default
hint: preference for all repositories. You can also pass --rebase, --no-rebase,
hint: or --ff-only on the command line to override the configured default per
hint: invocation.
remote: Enumerating objects: 17, done.
remote: Counting objects: 100% (17/17), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 10 (delta 6), reused 9 (delta 6), pack-reused 0
Unpacking objects: 100% (10/10), 1.85 KiB | 947.00 KiB/s, done.
From https://github.com/fusionSuite/backend
   3635219..c21ae80  master     -> origin/master
Updating 3635219..c21ae80
Fast-forward
 public/index.php              |  2 +-
 src/v1/Controllers/Status.php | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/v1/Route.php              |  1 +
 3 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 src/v1/Controllers/Status.php
```

* quit interactive terminal from image with ```exit```

* save update to your docker container

```docker ps -a```

```
CONTAINER ID        IMAGE                                     COMMAND             CREATED             STATUS                      PORTS               NAMES
173660e6ca62        laurentlienhard/fusionsuite-backend:DEV   "bash"              8 minutes ago       Exited (0) 34 seconds ago                       fusion-backend
```

```docker commit 173660e6ca62 fusionsuite-backend```

``` 
sha256:80dee25dac62d4d69c9b9135e9f45c00588ad7fe8131a613be7842aa051a9e2e
```

* tag and update image

```docker image ls```

```
REPOSITORY                            TAG                 IMAGE ID            CREATED             SIZE
fusionsuite-backend                   latest              80dee25dac62        22 seconds ago      864MB
laurentlienhard/fusionsuite-backend   DEV                 02a3aa27ad05        11 hours ago        864MB
```

```docker tag 80dee25dac62 laurentlienhard/fusionsuite-backend:DEV```

```docker push laurentlienhard/fusionsuite-backend:DEV```

```
The push refers to repository [docker.io/laurentlienhard/fusionsuite-backend]
5d1086cb6a2b: Pushed
2481dfa91c6b: Layer already exists
21499262a122: Layer already exists
266a66cb55fb: Layer already exists
11936051f93b: Layer already exists
DEV: digest: sha256:490d5c3adcb08bdd4337f1439be293f3e5eadaa05cab8d8a92a44a53e840e29e size: 1371
```


