FROM eclipse-temurin:11-jdk-noble
ARG BUILD_DIR=/opt/build
WORKDIR ${BUILD_DIR}

RUN apt update -y \
    && apt upgrade -y
RUN apt install \
    curl \
    unzip \
    python3 \
    scala \
    build-essential \
    -y
RUN ln -s /usr/bin/python3 /usr/bin/python
CMD ["bash"]