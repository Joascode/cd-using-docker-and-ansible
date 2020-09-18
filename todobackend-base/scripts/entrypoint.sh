#!/bin/bash
. /appenv/bin/activate

# Executes the given command arguments when starting the docker image
# This exec $@ passes the control of the current process (Bash) over to the next process, instead of creating a new process beside the current.
# This makes sure that the new process after entrypoint.sh doesn't receive a new ID.
# Without exec, bash would launch a new child application, with its own process ID.
# This is required, since Docker will send a SIGTERM command to PID 1 when shutting down the container.
# This makes the container shut down gracefully, instead of forced after the interval that docker waits for.
exec $@