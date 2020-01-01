#!/bin/bash
if [ -z `docker-compose ps -q finalweb1` ] || [ -z `docker ps -q --no-trunc | grep $(docker-compose ps -q finalweb1)` ]; then
  echo "finalweb1 is not running."
else
  echo "finalweb1 is running."
  docker-compose down  
fi
