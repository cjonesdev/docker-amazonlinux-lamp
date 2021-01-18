# Docker Amazon Linux LAMP

Creates a LAMP stack image using the official Amazon Linux image for [Docker](http://docker.com)

* Amazon Linux 2
* Apache 2.4
* PHP 7.3 (php-fpm)
* MySQL 5.7
* MongoDB 4.4

- remote access for MySQL and MongoDB

## Getting Started

This container is recommended for development use, to mirror or mimic development of an AWS EC2 instance running Amazon Linux 2. 


#### Build Image
Navigate to directory containing docker file. If downloading from Docker Hub, move on to "Create Container" section.

```
docker build -t imageName .
```


### Create Container

You will most likely want to develop on your local machine. Create your directory structure on your local machine and figure out where you want your web root to reside. Update the `-v ~/sites:/var/www/html` with the path to your working directory. `~/sites` in this example would be where your files reside locally, relative to the home directory. You can also use a full path. Don't change `:/var/www/html`.


If you built the image locally
```
# Custom Image Build
docker run -ti --name containerName -p 80:80 -p 3306:3306 -p 27017:27017 -v ~/sites:/var/www/html -d imagesName
```

### virtualhosts.conf

You can place the virtualhosts.conf file in your `~/sites` directory and add as many test sites as you like. Just copy the test.loc section and add the site domain to your hosts file. You'll need to restart Apache every time you update this file `docker exec -ti containerName service httpd restart`


### Working with MySQL

The MySQL username/password is setup with these default settings:

```
Host: localhost
User: root
Password: root
```
