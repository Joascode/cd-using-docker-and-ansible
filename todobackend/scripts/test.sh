#!/bin/bash
# Activate virtual environment
. /appenv/bin/activate

# Download requirements to build cache
# Since the requirements_text.txt file references the setup.py file, pip will
# also place a copy of the application source code in the /build folder.
pip download -d /build -r requirements_test.txt --no-input

# Install application test requirements
# The --no-index flags tells pip install to not download the external
# depedencies and instead use the /build folder.
pip install --no-index -f /build -r requirements_test.txt

# Run test.sh arguments
exec $@