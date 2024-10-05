FROM data-engineering/jdk-base:latest
ARG BUILD_DIR=/opt/build
WORKDIR ${BUILD_DIR}
ENV SPARK_HOME=/usr/bin/spark-3.5.3-bin-hadoop3
RUN mkdir -p ${SPARK_HOME}
RUN curl -LO https://dlcdn.apache.org/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz \
    && tar -xvzf spark-3.5.3-bin-hadoop3.tgz -C ${SPARK_HOME} --strip-components=1 \
    && echo "alias pyspark=/usr/bin/spark-3.5.3-bin-hadoop3/bin/pyspark" >> ~/.bashrc \
    && echo "alias spark-shell=/usr/bin/spark-3.5.3-bin-hadoop3/bin/spark-shell" >> ~/.bashrc \
    && mkdir /usr/bin/spark-3.5.3-bin-hadoop3/logs \
    && rm spark-3.5.3-bin-hadoop3.tgz
ENV SPARK_MASTER_HOST=spark-master.local
ENV SPARK_MASTER_PORT=7077
ENV PYSPARK_PYTHON=python3
ENV PATH=${PATH}:${SPARK_HOME}/sbin:${SPARK_HOME}/bin
WORKDIR ${SPARK_HOME}