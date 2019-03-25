#!/bin/bash

WORKER_COUNT=${1-1}

docker-compose build && docker-compose up -d && docker-compose scale jmeter-master=1 jmeter-worker=$WORKER_COUNT

WORKER_IP=$(docker inspect -f '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | grep jmeter-worker | awk -F' ' '{print $2}' | tr '\n' ',' | sed 's/.$//')
echo "Worker container IPs = $WORKER_IP"

WDIR=`docker exec -it jmeter-master /bin/pwd | tr -d '\r'`
echo "Master container working directory = $WDIR"

mkdir -p results
jmxFile="scripts/odyssey-experiment.jmx"
eval "docker cp $filename jmeter-master:$WDIR/scripts/"
resDir="/results"
eval "docker exec -it jmeter-master /bin/bash -c ls -l"
# eval "docker exec -it master /bin/bash -c 'jmeter -n -t $jmxFile -l $resDir/perfRes.jtl -R$WORKER_IP'"
# eval "docker cp master:$resDir results/"
done

docker-compose stop && docker-compose rm -f
