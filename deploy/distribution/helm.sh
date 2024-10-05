#!/bin/bash

# Install Docker Registry
helm repo add twuni https://helm.twun.io
helm install registry twuni/docker-registry
