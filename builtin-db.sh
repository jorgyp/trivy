#!/bin/bash
GCR_PATH=$1
TAG=$2

docker build -f ./Dockerfile-builtin-db -t gcr.io/$GCR_PATH/external/trivy:$TAG .

docker save "gcr.io/$(GCR_PATH)/external/trivy:$TAG" -o ./imagefile.tar
chmod 777 ./imagefile.tar

#scan image for vulnerability
securityScan=$(docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/opt/test aquasec/trivy --input /opt/test/imagefile.tar)

#fail if vulnerabilities found
if [[ $securityScan != *"CRITICAL: 0"* ]] || [[ $securityScan != *"HIGH: 0"* ]]; then 
    echo 'found high vulnerabilities' 
    exit 1 
else 
    echo 'no high vulnerability found'
fi

docker push gcr.io/$GCR_PATH/external/trivy:$TAG