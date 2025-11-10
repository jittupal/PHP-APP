#!/bin/bash
# Navigate to the app folder
cd /home/ec2-user/php-app

# Pull latest Docker image
docker pull 838693051190.dkr.ecr.eu-north-1.amazonaws.com/php-app:latest

# Stop and remove old container if exists
docker stop php-app-web || true
docker rm php-app-web || true

# Run new container
docker run -d --name php-app-web -p 80:80 838693051190.dkr.ecr.eu-north-1.amazonaws.com/php-app:latest
