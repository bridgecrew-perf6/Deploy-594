#!/bin/bash

url="https://raw.githubusercontent.com/69pmb/Deploy/main/docker/ng-build/Dockerfile"
dockerfile=$(curl -s $url)

function getArgVersion() {
  local version=$(echo $dockerfile | sed 's/ /\n/g' | grep -i ''"$1"'_version=' | cut -d = -f2)
  echo $version
}

select project in Dsm-Landing AllMovies NgMusic Manual
do
  if [[ ! -z $project ]]
  then
    echo $project
    if [[ $project == "Manual" ]]
    then
      let pj;
      while [ -z $pj ]
      do
        read -p "Which project ? " pj
      done
      project=$pj
    else
      echo "You have selected '$project'"
    fi
    let directory;
    read -p "Enter the Github directory [69pmb]: " directory
    directory=${directory:-69pmb}
    
    let hash;
    read -p "Enter the Github commit Hash [master]: " hash
    hash=${hash:-master}

    let node;
    node_version=$(getArgVersion "node")
    read -p "Enter the NodeJs version [$node_version]: " node
    node=${node:-$node_version}

    let nginx;
    nginx_version=$(getArgVersion "ng_nginx")
    read -p "Enter the pmb69/Ng-Nginx version [$nginx_version]: " nginx
    nginx=${nginx:-$nginx_version}

    let angular;
    angular_version=$(getArgVersion "angular")
    read -p "Enter the Angular version [$angular_version]: " angular
    angular=${angular:-$angular_version}
    break;
  else
    echo " You have entered wrong option, please choose the correct option from the listed menu."
  fi
done

cmd="docker build --build-arg GITHUB_DIR=$directory --build-arg GITHUB_PROJECT=$project --build-arg GITHUB_HASH=$hash --build-arg NODE_VERSION=$node --build-arg ANGULAR_VERSION=$angular --build-arg NG_NGINX_VERSION=$nginx --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" -t ${project,,} $url"

echo -e "Do you want to run the following command:\n$(echo $cmd | sed 's/--/\n  --/g' | sed 's/https/\n  https/g')"
let choice
while [ -z $choice ]
do
	read -p "[y/n] #? " choice
	if [[ $choice =~ ^(y|Y)([eE][sS])?$ ]]
	then 
	  echo $($cmd)
	elif [ ! -z $choice ]
	then 
	  echo "Do nothing"
	fi
done
