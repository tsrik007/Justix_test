#!/bin/bash

  function main() {
   installDocker
   installNginx
  }

  function installDocker(){
    export DEBIAN_FRONTEND=noninteractive
			apt-get -y update
			apt-get install \
			apt-transport-https \
			 ca-certificates \
			curl \
			software-properties-common
			curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
			apt-key fingerprint 0EBFCD88
			add-apt-repository \
			"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
			$(lsb_release -cs) \
			stable"
			apt-get -y update
			apt-get -y install docker-ce
	}

    function installNginx() {
      echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" | sudo tee -a /etc/apt/sources.list
      echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" | sudo tee -a /etc/apt/sources.list
			  cd /tmp/ && wget http://nginx.org/keys/nginx_signing.key
			  sudo apt-key add nginx_signing.key
        sudo apt-get -y update
        sudo apt-get install -y nginx
			  mkdir -p /etc/nginx/ssl
			  // cp -p /tmp/config/nginx.crt /tmp/config/nginx.key /etc/nginx/ssl/
			  // cp -p /tmp/config/vaultier.nginx.conf /tmp/config/common.part /etc/nginx/conf.d/
			  // rm -f /etc/nginx/conf.d/default.conf
			  service nginx restart
  }

  main
