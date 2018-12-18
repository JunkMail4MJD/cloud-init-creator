#!/bin/bash
printf "\nInitializing...\n\n"
rm -f fail-no-files/config-data.iso
rm -f fail-no-user-data/config-data.iso
rm -f succeed-both-files/config-data.iso
rm -f succeed-user-data/config-data.iso
rm -Rf test-results
mkdir test-results

printf "Starting Test Containers...\n\n"
docker run -d --name cic-fail-no-files -v $(pwd)/fail-no-files/:/usr/src/files cloud-init-creator:v0.0.1
docker run -d --name cic-fail-no-user-data -v $(pwd)/fail-no-user-data/:/usr/src/files cloud-init-creator:v0.0.1
docker run -d --name cic-succeed-user-data -v $(pwd)/succeed-user-data/:/usr/src/files cloud-init-creator:v0.0.1
docker run -d --name cic-succeed-both-files -v $(pwd)/succeed-both-files/:/usr/src/files cloud-init-creator:v0.0.1

sleep 5

docker logs cic-fail-no-files > test-results/cic-fail-no-files.txt 2>> test-results/cic-fail-no-files.txt
docker logs cic-fail-no-user-data > test-results/cic-fail-no-user-data.txt 2>> test-results/cic-fail-no-user-data.txt
docker logs cic-succeed-user-data > test-results/cic-succeed-user-data.txt 2>> test-results/cic-succeed-user-data.txt
docker logs cic-succeed-both-files > test-results/cic-succeed-both-files.txt 2>> test-results/cic-succeed-both-files.txt

./check-results.py

printf "Deleted container $(docker rm cic-fail-no-files)\n"
printf "Deleted container $(docker rm cic-fail-no-user-data)\n"
printf "Deleted container $(docker rm cic-succeed-user-data)\n"
printf "Deleted container $(docker rm cic-succeed-both-files)\n\n"
