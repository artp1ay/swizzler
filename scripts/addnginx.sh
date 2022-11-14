#!/bin/bash

if [ -z "$1" ]
then
	echo ""
  echo "You must specify the domain!"
  echo ""
  echo "Example: bash $0 yoursite.com"
  echo ""
  exit 1
fi

if [ ! -f "./.env" ]; then
	echo ""
	echo "No .env file found in current directory."
	echo ""
	echo "You must rename example.env -> .env and try again."
	echo ""
	exit 1
fi;

source .env

DOMAIN=$1

NGINX_SITES_PATH="/etc/nginx/sites-available/"
NGINX_REVERSE_PROXY="
server {
		listen 80;
		listen [::]:80;
		server_name $DOMAIN;

		location / {
				proxy_pass http://[::]:$PORT;
				proxy_set_header Host \$host;
				proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
				proxy_set_header X-Real-IP $remote_addr;
		}
}
"

if [ -f $NGINX_SITES_PATH ]; then
	echo ""
	echo "Default Nginx directory /etc/nginx/sites-available/ not found."
	echo ""
	echo "Maybe Nginx package is not installed or using unsupported distros."
	echo ""
	exit 1
fi;

# Writing to file
echo "$NGINX_REVERSE_PROXY" > "$NGINX_SITES_PATH"/$DOMAIN.conf

# Making symlink
ln -s /etc/nginx/sites-available/$DOMAIN.conf /etc/nginx/sites-enabled/

# Check
if nginx -t | grep -q 'failed'; then
	echo ""
	echo "Some errors was occured while checking Nginx configs."
	echo ""
	echo "Try to fix it with command: \"nginx -t\" and try again after fixing"
	echo ""
	exit 1
else
	nginx -s reload
	echo ""
	echo "Nginx was reloaded"
	echo ""
	echo "Done!"
	exit 0
fi

