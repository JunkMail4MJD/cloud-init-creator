#!/bin/bash
help () {
  cat <<- END
	HELP: Script to build the cloud-init-creator docker image
	------------------------------------------
    ./build-docker-image.sh <version tag>

    Example: ./build-docker-image.sh v0.0.1

	END
}
parameterCount=$#
if (( parameterCount != 1 )); then
  RED="\033[1;31m"
  RESET="\033[0;0m"
  printf "\n${RED}Illegal number of parameters: ${parameterCount}!\n\n${RESET}------------------------------------------\n";
  help;
  exit 1;
fi
echo "Build cloud-init-creator image..."
docker build -t cloud-init-creator:${1} .
