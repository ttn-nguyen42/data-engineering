FROM data-engineering/spark-base:latest
EXPOSE 8081
ENV SPARK_MASTER_HOST=spark-master.local
ENV SPARK_MASTER_PORT=7077
CMD bin/spark-class org.apache.spark.deploy.worker.Worker spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT} >> logs/spark-worker.out