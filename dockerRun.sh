#!/usr/bin/env bash

sudo docker stop hello
sudo docker rm hello
sudo docker run --name hello -p 3000:3000  jonas27/hello:v5
