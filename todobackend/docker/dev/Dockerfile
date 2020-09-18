# Build this image with the --env-file=.env tag
FROM joaskramer/todobackend-base:latest
LABEL maintainer="Joas Kramer"

# Install dev/build dependencies
RUN apt-get update && \
  apt-get install -qy python-dev libmysqlclient-dev

# Activate virtual environment and install wheel support.
# Wheel is used to build artefacts used for deployment.
RUN . /appenv/bin/activate && \
  pip install wheel --upgrade

# PIP environment variables (NOTE: must be set after installing wheel)
ENV WHEELHOUSE=/wheelhouse PIP_WHEEL_DIR=/wheelhouse PIP_FIND_LINKS=/wheelhouse XDG_CACHE_HOME=/cache

# OUTPUT: Build artefacts (Wheels) are output here
# OUTPUT: Test reports are output here
VOLUME [ "/reports", "/wheelhouse" ]

# Add test entrypoint script
COPY scripts/test.sh /usr/local/bin/test.sh
RUN chmod +x /usr/local/bin/test.sh

ENTRYPOINT [ "test.sh" ]
CMD [ "python", "manage.py", "test", "--noinput", "--exe"]

COPY src /application
WORKDIR /application