#!/bin/bash

source .env
docker build -t bpt:latest -t bpt:$VERSION .
