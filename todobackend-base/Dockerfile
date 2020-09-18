FROM ubuntu:trusty
LABEL maintainer="Joas Kramer"

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set mirrors to local Docker repository
# This example sets the new repository to NZ.
# RUN sed -i "s/http:\/\/archive./http:\/\/nz.archive./g" /etc/apt/sources.list

RUN apt-get update && \
  apt-get install -y \
  -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
  python python-virtualenv
# Uses python-virtualenv instead of installing it via pip. This keeps a separation between base image requirements and application dependencies.

# Instead of source, we use the . operator. Which is required inside Dockerfile, since docker doesn't support the use of source in the shell.
RUN virtualenv /appenv && \
  . /appenv/bin/activate && \
  pip install pip --upgrade

# The local/bin folder is included in the default path of Linux environments
# Which means the entrypoint script is available from anywhere, independent of our current working directory.
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]