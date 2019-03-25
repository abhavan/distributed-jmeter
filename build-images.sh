#!/bin/bash

docker build -t jmeter/base:latest base/.
docker build -t jmeter/master:latest master/.
docker build -t jmeter/worker:latest worker/.