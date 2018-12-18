#!/bin/bash
if [ -z "$BASH_VERSION" ] ; then
   echo 'Boot Info Script needs to be run with bash as shell interpreter.' >&2;
   exit 1;
fi

help () {
  cat <<- END
	Create Generic VirtualBox VM Script:
  ------------------------------------------
    ./tag-and-push-to-dockerhub.sh <version tag>

    Example: ./tag-and-push-to-dockerhub.sh v0.0.1

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

echo "Tagging and pushing Version $1 to Docker Hub"
docker tag cloud-init-creator:$1 junkmail4mjd/cloud-init-creator:$1
docker push junkmail4mjd/cloud-init-creator:$1
