#!/bin/bash

#github profile name
echo "Please input the github username"
read USERNAME

echo "Please input your Personal access tokens (classic) => https://github.com/settings/tokens"
read CR_PAT

#app settings
APP_NAME=cloud-app
APP_VER=0.0.1

#login to github
echo "==========================================="
echo "1. Login to github docker registry (packages)"
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
echo "==========================================="

echo "2. Building Docker Image from Dockerfile"

docker build -t $APP_NAME:$APP_VER -f Dockerfile .

echo "Docker image built successfully."
echo "==========================================="

echo "3. Removing previous docker if exists"

docker rm $APP_NAME -f

echo "==========================================="
echo "4. Running Docker Container"

docker run -d -p 8080:8080 --name $APP_NAME $APP_NAME:$APP_VER

echo "The application is running in the Docker container at http://localhost:8080"
echo "==========================================="

#View all running docker containers
echo "View all running containers"
echo "==========================================="

docker ps

echo "5. Publishing Docker Image to Github's Docker Registry"
docker tag $APP_NAME:$APP_VER ghcr.io/$USERNAME/$APP_NAME:$APP_VER
docker push ghcr.io/$USERNAME/$APP_NAME:$APP_VER
echo "Docker image published to Docker registry."
echo "==========================================="


#echo "Deploying Docker Image to a Kubernetes Cluster"
#kubectl create deployment cloud-app --image=your-docker-repo/cloud-app:0.0.1
#kubectl expose deployment cloud-app --type=LoadBalancer --port=80 --target-port=8080
#echo "Docker image deployed to Kubernetes cluster."

#echo "Scaling the Application"
#kubectl scale deployment cloud-app --replicas=3
#echo "Kubernetes cluster scaled the application to 3 replicas."
#
#echo "Updating the Application without Downtime"
#kubectl set image deployment/cloud-app cloud-app=your-docker-repo/cloud-app:0.0.2
#echo "Kubernetes cluster updated the application without downtime."
#
#echo "Rolling Back the Application to a Previous Version"
#kubectl rollout undo deployment/cloud-app
#echo "Kubernetes cluster rolled back the application to the previous version."
#
#echo "Monitoring the Application"
#kubectl apply -f monitoring.yaml
#echo "Monitoring configured for the Kubernetes cluster."
#
#echo "Autoscaling the Application Based on the Load"
#kubectl autoscale deployment cloud-app --min=2 --max=10 --cpu-percent=80
#echo "Kubernetes cluster configured to autoscale the application based on the load."
#
#echo "Storing Application Logs in a Centralised Logging System"
#kubectl apply -f logging.yaml
#echo "Centralized logging configured for the application."
#
#echo "Sending Metrics to a Monitoring System"
#kubectl apply -f metrics.yaml
#echo "Metrics configured to be sent to the monitoring system."
#
#echo "Running Database on a Separate Container"
#docker run -d --name database -v /my/own/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -e MYSQL_DATABASE=tech_challenge mysql:5.7
#echo "Database is running on a separate container."
#
#echo "Mounting Storage to the Database Container"
#docker run -d --name database -v /path/to/local/storage:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -e MYSQL_DATABASE=tech_challenge mysql:5.7
#echo "Storage mounted to the database container."
