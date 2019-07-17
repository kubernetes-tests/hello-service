#!/usr/bin/env bash
docker build . -t jonas27/hello:v5arm
docker push jonas27/hello:v5arm
