FROM nginxinc/nginx-unprivileged:1-alpine

# Copy the files created into the docker image and the location 
# especified
COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./uwsgi_params /etc/nginx/uwsgi_params
COPY ./run.sh /run.sh

# Define default variables
ENV LISTEN_PORT=8000
# Name of the service thats is running our container and django app
ENV APP_HOST=app
ENV APP_PORT=9000

USER root

# 1: Create the static directory
# 2: Change the permissions of the directory
# 3: Create file
# 4: Change owner of the empty file to nginx user to fullfill
#    the best practices of not running our app as root user
# 5: Gives execitable permission to our run script
RUN mkdir -p /vol/static && \
    chmod 755 /vol/static && \
    touch /etc/nginx/conf.d/default.conf && \
    chown nginx:nginx /etc/nginx/conf.d/default.conf && \
    chmod +x /run.sh

# Usefull to deploy app to different server
VOLUME /vol/static

# Switches back from root user to nginx user
USER nginx

# We don't need to specify a docker compose, we simply need to run the image
# that is the default script
CMD [ "/run.sh" ]