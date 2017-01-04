# docker-phpstan

[PHPStan](https://github.com/phpstan/phpstan) is a very great tool. 

But to avoid adding PHPStan as a project requirement or to check PHP 5.x applications which are not compatible with PHPStan as a 
dependency you can use this docker container.

This Docker container comes with PHP 7.1 because of prerequisities and pre-installed PHPStan. 
To check your applications source code simple mount them into the container and have fun.
Usage examples can be found below.

## Requirements

* Docker

## Usage

Before start, keep in mind that when you run the container the executable in this 
is always "phpstan". So all parameters after "tommymuehle/docker-phpstan" in the commands below are given to this executable.

* Basic usage

```
docker run --rm -v /path/to/app:/app tommymuehle/docker-phpstan analyse /app/src
```

* with multiple folders

```
docker run --rm -v /path/to/app:/app tommymuehle/docker-phpstan analyse /app/src /app/tests
```

* with higher level

```
docker run --rm -v /path/to/app:/app tommymuehle/docker-phpstan analyse /app/src --level=5
```

* with external PHAR tools

Often external PHAR tools in projects are used, like PHPUnit or phpmd.
But then PHPStan can't find this classes via autoload. For example 
the "PHPUnit_Framework_TestCase" class. 

To run also this checks you must implement a separate autoload file and 
include the PHAR files. This file can confident added to .gitignore.

A simple script to do this can look like this:

```
$ cat phpstan-autoload.php 

<?php
include __DIR__ . '/bin/phpunit.phar';
// ... further PHAR files
require __DIR__ . '/vendor/autoload.php';
```

The result, on one line, is this usage example:

```
docker run --rm -v /path/to/app:/app tommymuehle/docker-phpstan analyse --autoload-file=phpstan-autoload.php /app/src /app/tests
```
