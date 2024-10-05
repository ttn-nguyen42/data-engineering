FROM data-engineering/jdk-base:latest
ARG DEBIAN_FRONTEND=noninteractive
ARG WORKSPACE=/opt/workspace
RUN apt update && apt install -y \ 
    python3-pip \
    python3-dev \
    python3-venv \
    ca-certificates-java \
    --no-install-recommends
COPY jupyterlab/requirements.txt requirements.txt
# Create and activate a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt
RUN curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs \
    && chmod +x cs \
    && ./cs setup --yes \
    && mv cs /usr/local/bin/cs
RUN cs launch \
    --fork almond:0.10.9 \
    -- \
    --display-name "Scala" \
    --install
EXPOSE 8888
WORKDIR ${WORKSPACE}
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token="]