#Create an image for docker based python environment with visual studio code IDE installed as a service listening in port 8443

FROM ubuntu:18.04

FROM python:2.7

RUN pip install virtualenv
ENV VIRTUAL_ENV=/opt/venv
RUN virtualenv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN . /opt/venv/bin/activate

#RUN >/var/lib/dpkg/lock-frontend

RUN apt update \
 && apt upgrade -y \
 && apt install -y sudo \
 && apt-get install -y wget 

COPY . /tmp/i-vagrant
WORKDIR /tmp/i-vagrant

RUN wget https://github.com/cdr/code-server/releases/download/1.1156-vsc1.33.1/code-server1.1156-vsc1.33.1-linux-x64.tar.gz \
    && tar -xzvf code-server1.1156-vsc1.33.1-linux-x64.tar.gz && chmod +x code-server1.1156-vsc1.33.1-linux-x64/code-server

ADD . /code /code/

CMD ./code-server1.1156-vsc1.33.1-linux-x64/code-server --allow-http --no-auth --data-dir /data /code

