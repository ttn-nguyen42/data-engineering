#!/bin/bash

BASE_IMAGE=data-engineering/jdk-base:latest
SPARK_BASE_IMAGE=data-engineering/spark-base:latest
SPARK_MASTER_IMAGE=data-engineering/spark-master:latest
SPARK_WORKER_IMAGE=data-engineering/spark-worker:latest
JUPYTERLAB_IMAGE=data-engineering/jupyterlab:latest

function cleanContainers() {
    container="$(docker ps -a | grep 'jupyterlab' | awk '{print $1}')"
    docker stop "${container}"
    docker rm "${container}"

    container="$(docker ps -a | grep 'spark-worker' -m 1 | awk '{print $1}')"
    while [ -n "${container}" ]; do
        docker stop "${container}"
        docker rm "${container}"
        container="$(docker ps -a | grep 'spark-worker' -m 1 | awk '{print $1}')"
    done

    container="$(docker ps -a | grep 'spark-master' | awk '{print $1}')"
    docker stop "${container}"
    docker rm "${container}"

    container="$(docker ps -a | grep 'spark-base' | awk '{print $1}')"
    docker stop "${container}"
    docker rm "${container}"

    container="$(docker ps -a | grep 'base' | awk '{print $1}')"
    docker stop "${container}"
    docker rm "${container}"
}

function cleanImages() {
    docker rmi -f "$(docker images | grep -m 1 $JUPYTERLAB_IMAGE | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 $SPARK_MASTER_IMAGE | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 $SPARK_WORKER_IMAGE | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 $SPARK_BASE_IMAGE | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 $BASE_IMAGE | awk '{print $3}')"
}

function buildImages() {
    docker build \
        -f base/Dockerfile \
        -t $BASE_IMAGE .

    docker build \
        -f spark-base/Dockerfile \
        -t $SPARK_BASE_IMAGE .

    docker build \
        -f spark-master/Dockerfile \
        -t $SPARK_MASTER_IMAGE .

    docker build \
        -f spark-worker/Dockerfile \
        -t $SPARK_WORKER_IMAGE .

    docker build \
        -f jupyterlab/Dockerfile \
        -t $JUPYTERLAB_IMAGE .
}

cleanContainers
cleanImages
buildImages
