ARG PYTORCH_IMAGE=nvcr.io/nvidia/pytorch:21.08-py3
FROM ${PYTORCH_IMAGE}

COPY requirements.txt requirements.txt 
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y


# NGC Client
WORKDIR /opt/tools
ARG NGC_CLI_URI="https://ngc.nvidia.com/downloads/ngccli_linux.zip"
RUN wget -q ${NGC_CLI_URI} && unzip ngccli_linux.zip && chmod u+x ngc-cli/ngc && \
    find ngc-cli/ -type f -exec md5sum {} + | LC_ALL=C sort | md5sum -c ngc-cli.md5 && \
    rm -rf ngccli_linux.zip ngc-cli.md5
ENV PATH=${PATH}:/opt/tools:/opt/tools/ngc-cli
RUN apt-get update \
  && DEBIAN_FRONTEND="noninteractive" apt-get install -y libopenslide0  \
  && rm -rf /var/lib/apt/lists/*

ENV PATH=${PATH}:/opt/tools
ENV USERNAME="patchcore-docker-dev"

WORKDIR /opt/patchcore

EXPOSE 6007

COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT [ "/bin/bash", "/docker-entrypoint.sh" ]
CMD ["Docker"]