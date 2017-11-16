# docker-xhgui
docker-xhgui is a contenerization of Perftool's xhgui project ( https://github.com/perftools/xhgui )

You have to know it's a **quick and dirty** solution.

It's dirty because :

- It cloning xhgui project from master branch
- there is no database credentials
- no apache optimization

It's highly depreciated to use this application in production. 

Ideally, **You should run the app in a isolated environment and import manually xhprof files.**

## Environment details

- Debian Stretch
- PHP 7.0
- Mongodb  3.2.11
- Apache 2.4
- Tideways Apache plug-in

## How to build

1. First, clone the repository wherever you want 
2. Goto the repo directory
3. build the container
4. That's it !

```bash
git clone git@github.com:DvdChe/docker-xhgui.git
cd docker-xgui
sudo docker build . -t <yourimagename>
```



## How to run

I recommend to use the docker-compose.yml file to configure your environment.

```yaml
version: '2'

services:
    xhgui:
        image: <yourimagename>
        container_name: xhgui
        network_mode: bridge
        #2 volumes are required. www and /data for data persistance.
        volumes: 
            - ./www:/var/www/ 
            - ./data:/data/
        ports: 
            - 8080:80
tty: true
```

Once docker-compose.yml is configured as you want, just put up your container : 

```bash
sudo docker-compose up -d
```

On the first run, the entrypoint script will configure mongodb database, apache and run the xhgui installation with Composer

