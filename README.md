# Deploying Django with Docker Compose

## Useful commands

Delete all containers using the following command

    docker rm -f $(docker ps -a -q)

Delete all volumes using the following command

    docker volume rm $(docker volume ls -q)

Create a new django project

    docker-compose run --rm app sh -c "django-admin startproject app ."

Create new django app

    docker-compose run --rm app sh -c "python3 manage.py startapp core"