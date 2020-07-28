#!/bin/bash

# # at least 1 argument to be pass in
# if  [ $# == 0 ]; then
#     echo "run.sh needs a service module package to run"
#     echo "eg: run.sh gate.service api.service"
#     exit 1
# fi

alembic upgrade head

PYTHONPATH=.
if [ -n "${DEBUG}" ]; then
    echo "FastAPI service in debug mode. please connect to port 5678 to start service"
    GEVENT_SUPPORT=True python -m debugpy --listen 5678 --wait-for-client app/main.py $@
else
    python -m app.main $@
fi
