FROM python:3.9-alpine3.13

# Pythont don't buffer the output
ENV PYTHONUNBUFFERED 1

# Copy requirements to docker image
COPY ./requirements.txt /requirements.txt
# Cope app to docker image
COPY ./app /app
COPY ./scripts /scripts

# Tell docker the working directory of the new container 
WORKDIR /app
# Port 
EXPOSE 8000

# apk: Alpine package manager
# 1: Create a venv inside docker image to store python dependencies
# 2: Upgrade pip
# 3: Dependencies needed AFTER the postgres driver is installed
# 4: Temporary dependencies needed to install the driver
# 5: Install requirements
# 6: Once installed we can remove this dependencies to keep image light weight
# 7: Create use with no password and no home dir with username equal to app
#    otherwise you will login as root user
# 8: Creates a new directory to contain static files i.e. css,js
# 9: Creates media directory to contain media file. Media file uploaded by user
# 10: Change the ownership of the file
# 11: Change default permissions
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
      build-base postgresql-dev musl-dev linux-headers && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home app && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R app:app /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts

# When run python command we don't have to specify /py/bin
# because it will be added to the path
ENV PATH="/scripts:/py/bin:$PATH"

# Swithces user from root user (default user) to app user
USER app

CMD [ "run.sh" ]