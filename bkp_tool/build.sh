#!/bin/bash
set -e

docker build -t mysql-backup-container:latest .
docker tag jgmurua/mysql-backup-container:latest
docker push jgmurua/mysql-backup-container:latest
