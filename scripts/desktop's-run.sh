#!/bin/bash
code '/Users/oladeanio/Library/CloudStorage/GoogleDrive-alfienurse@gmail.com/My Drive/Uni/Undergrad/BSc (Hons) Computer Science (Artificial Intelligence) (7392)/Year_2/Semester 1/COMP2001/CW/2001-cw'

# 1- kill all running containers; initially
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)


# 2- pull the latest image from docker hub
docker pull oladeanio/trail-api:latest
docker run -it -p 8000:8000 --name trail-api-container oladeanio/trail-api:latest


