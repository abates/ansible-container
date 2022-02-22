FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends python3 python3-pip yamllint git && \
    apt-get autoremove -y && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --system --shell /bin/bash --create-home --home-dir /opt/ansible ansible

USER ansible

RUN pip3 install ansible ansible-lint
ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

