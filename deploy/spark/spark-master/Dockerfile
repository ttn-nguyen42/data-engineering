FROM data-engineering/spark-base:latest
EXPOSE 8080 7077
ENV SPARK_MASTER_HOST=spark-master.local
ENV SPARK_MASTER_PORT=7077
CMD bin/spark-class org.apache.spark.deploy.master.Master --host ${SPARK_MASTER_HOST} --port ${SPARK_MASTER_PORT} >> logs/spark-master.out