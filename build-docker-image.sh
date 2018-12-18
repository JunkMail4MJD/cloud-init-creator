#!/bin/bash
if [ -z "$BASH_VERSION" ] ; then
   echo 'Boot Info Script needs to be run with bash as shell interpreter.' >&2;
   exit 1;
fi

help () {
  cat <<- END
	HELP: Create Generic VirtualBox VM Script:
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
docker build -t cloud-init-creator:${1} .
