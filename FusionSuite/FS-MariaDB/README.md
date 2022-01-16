# How to run FusionSuite (DEV) on docker

## 01-Install

Clone repository on your computer

```git clone https://github.com/LaurentLienhard/Docker.git C:\MyDev\Test```

Go to directory FS-MariaDB

```cd C:\MyDev\Test\FusionSuite\FS-MariaDB\```

and run

```docker-compose up -d```

```text
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
Digest: sha256:ae58d6e4c09f3c6a23f1af96234caeef4f0ac4cf2ccc1744873f961c18e37c5e
Status: Downloaded newer image for laurentlienhard/fusionsuite-backend:DEV
Creating fs-mariadb_backend-mariadb_1 ... done
```

## 02-Check

if you run ```docker ps``` you should see something like this

```text
CONTAINER ID        IMAGE                                     COMMAND             CREATED             STATUS              PORTS                NAMES
3baa8bb69fab        laurentlienhard/fusionsuite-backend:DEV   "./entrypoint.sh"   4 minutes ago       Up 4 minutes        0.0.0.0:80->80/tcp   fs-mariadb_backend-mariadb_1
 ```

 The container with name ```fs-mariadb_backend-mariadb_1``` is running

 Open a browser en try : ```http://localhost/ping```

 The response should be ```pong```

 Open a browser en try : ```http://localhost/v1/status```

 The response should be ```{"connections":{"database":true}}```

 Congratulation FusionSuite backend is running !

## install frontend (note perso)

* NodeJs

```apt-get update && apt-get upgrade -y```

```apt-get install curl -y```

```curl -fsSL https://deb.nodesource.com/setup_current.x | bash -```

```apt-get update ```

```apt-get install nodejs -y```


* yarn

```curl -o- -L https://yarnpkg.com/install.sh | bash```

* nginx

```apt-get install nginx -y```

* git

```apt-get install git -y```

* create directory

```mkdir /var/www/fusionsuite```

* Clone repository

```git clone https://github.com/fusionSuite/frontend.git /var/www/fusionsuite/frontend```

* install yarn

```cd /var/www/fusionsuite/frontend```

```yarn install```

```text
yarn install v1.22.17
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
warning " > @ionic-native/core@5.36.0" has incorrect peer dependency "rxjs@^5.5.0 || ^6.5.0".
warning " > @ionic-native/splash-screen@5.36.0" has incorrect peer dependency "rxjs@^5.5.0 || ^6.5.0".
warning " > @ionic-native/status-bar@5.36.0" has incorrect peer dependency "rxjs@^5.5.0 || ^6.5.0".
warning "@ionic/angular-toolkit > @angular-devkit/build-angular@12.2.14" has incorrect peer dependency "@angular/compiler-cli@^12.0.0".
warning "@ionic/angular-toolkit > @angular-devkit/build-angular@12.2.14" has incorrect peer dependency "typescript@~4.2.3 || ~4.3.2".
warning "@ionic/angular-toolkit > copy-webpack-plugin@9.1.0" has unmet peer dependency "webpack@^5.1.0".
warning "@ionic/angular-toolkit > @angular-devkit/build-angular > @ngtools/webpack@12.2.14" has incorrect peer dependency "@angular/compiler-cli@^12.0.0".
warning "@ionic/angular-toolkit > @angular-devkit/build-angular > @ngtools/webpack@12.2.14" has incorrect peer dependency "typescript@~4.2.3 || ~4.3.2".
warning " > codelyzer@6.0.2" has incorrect peer dependency "@angular/compiler@>=2.3.1 <13.0.0 || ^12.0.0-next || ^12.1.0-next || ^12.2.0-next".
warning " > codelyzer@6.0.2" has incorrect peer dependency "@angular/core@>=2.3.1 <13.0.0 || ^12.0.0-next || ^12.1.0-next || ^12.2.0-next".
[4/4] Building fresh packages...
Done in 131.48s.
```

* compile

```./node_modules/.bin/ionic build --prod -- --aot=true --buildOptimizer=true --optimization=true --vendor-chunk=true```

```text
> ng run app:build:production --aot=true --buildOptimizer=true --optimization=true --vendor-chunk=true
Node.js version v17.3.1 detected.
Odd numbered Node.js versions will not enter LTS status and should not be used for production. For more information, please see https://nodejs.org/en/about/releases/.
⠙ Generating browser application bundles (phase: setup)...Processing legacy "View Engine" libraries:
- @ionic-native/core [module/esm5] (https://github.com/ionic-team/ionic-native.git)
- @ionic-native/splash-screen [module/esm5] (https://github.com/ionic-team/ionic-native.git)
- @ionic-native/status-bar [module/esm5] (https://github.com/ionic-team/ionic-native.git)
Encourage the library authors to publish an Ivy distribution.
✔ Browser application bundle generation complete.
✔ Copying assets complete.
⠋ Generating index html...10 rules skipped due to selector errors:
  :host-context([dir=rtl]) .ion-float-start -> subselects_1.subselects[name] is not a function
  :host-context([dir=rtl]) .ion-float-end -> subselects_1.subselects[name] is not a function
  :host-context([dir=rtl]) .ion-float-sm-start -> subselects_1.subselects[name] is not a function
  :host-context([dir=rtl]) .ion-float-sm-end -> subselects_1.subselects[name] is not a function
  :host-context([dir=rtl]) .ion-float-md-start -> subselects_1.subselects[name] is not a function
  :host-context([dir=rtl]) .ion-float-md-end -> subselects_1.subselects[name] is not a function
  :host-context([dir=rtl]) .ion-float-lg-start -> subselects_1.subselects[name] is not a function
  :host-context([dir=rtl]) .ion-float-lg-end -> subselects_1.subselects[name] is not a function
  :host-context([dir=rtl]) .ion-float-xl-start -> subselects_1.subselects[name] is not a function
  :host-context([dir=rtl]) .ion-float-xl-end -> subselects_1.subselects[name] is not a function
✔ Index html generation complete.
....
```

* update config.json to point to backend url

```vim /var/www/fusionsuite/frontend/www/config.json```

* configure nginx to point to folder /var/www/fusionsuite/frontend/www/

```rm /etc/nginx/sites-enabled/default```

```vim /etc/nginx/sites-available/fusionsuite.conf```

example

```text
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /var/www/fusionsuite/frontend/www;
  index index.php index.html;
  server_name _;

  location / {
    allow        127.0.0.1;
  }
}
```

* enable the configuration and start NGINX

```ln -s /etc/nginx/sites-available/fusionsuite.conf /etc/nginx/sites-enabled/fusionsuite.conf```

```service nginx start```












## Update backend docker image (note perso)

* run docker image from hub

```docker run --name fusion-backend -p 80:80 -it laurentlienhard/fusionsuite-backend:DEV```

```text
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

```text
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

```text
CONTAINER ID        IMAGE                                     COMMAND             CREATED             STATUS                      PORTS               NAMES
173660e6ca62        laurentlienhard/fusionsuite-backend:DEV   "bash"              8 minutes ago       Exited (0) 34 seconds ago                       fusion-backend
```

```docker commit 173660e6ca62 fusionsuite-backend```

``` text
sha256:80dee25dac62d4d69c9b9135e9f45c00588ad7fe8131a613be7842aa051a9e2e
```

* tag and update image

```docker image ls```

```text
REPOSITORY                            TAG                 IMAGE ID            CREATED             SIZE
fusionsuite-backend                   latest              80dee25dac62        22 seconds ago      864MB
laurentlienhard/fusionsuite-backend   DEV                 02a3aa27ad05        11 hours ago        864MB
```

```docker tag 80dee25dac62 laurentlienhard/fusionsuite-backend:DEV```

```docker push laurentlienhard/fusionsuite-backend:DEV```

```text
The push refers to repository [docker.io/laurentlienhard/fusionsuite-backend]
5d1086cb6a2b: Pushed
2481dfa91c6b: Layer already exists
21499262a122: Layer already exists
266a66cb55fb: Layer already exists
11936051f93b: Layer already exists
DEV: digest: sha256:490d5c3adcb08bdd4337f1439be293f3e5eadaa05cab8d8a92a44a53e840e29e size: 1371
```
