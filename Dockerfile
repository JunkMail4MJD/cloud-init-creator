# -------------------------------
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install cloud-utils -y

WORKDIR /usr/src/files
WORKDIR /usr/src
COPY create-cloud-init-iso.sh /usr/src
CMD [ "/usr/src/create-cloud-init-iso.sh" ]
