FROM centos:centos7
MAINTAINER tubone24 <tubo.yyyuuu@gmail.com>

## install util
RUN yum -y update \
 && yum -y install \
     epel-release \
     gcc \
     git \
     vim \
     which \
     && yum clean all

# https://www.python.jp/install/centos/index.html
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install -y \
     python36u \
     python36u-devel \
     python36u-pip \
 && yum clean all \
 && ln -sf /usr/bin/python3.6 /usr/bin/python3 \
 && ln -sf /usr/bin/pip3.6 /usr/bin/pip3 \
 && pip3 install --upgrade pip

ENV PORT 80
RUN mkdir /app
RUN cd /app && git clone https://github.com/tubone24/rr-weather-data-with-aws.git
WORKDIR /app/rr-weather-data-with-aws/dash_visual/src/
RUN pip3 install -r requirements.txt
ADD assets/result_all.csv /app/rr-weather-data-with-aws/dash_visual/src/
ADD assets/result_timeserias_all.csv /app/rr-weather-data-with-aws/dash_visual/src/
ADD assets/result_kanto.csv /app/rr-weather-data-with-aws/dash_visual/src/
CMD python3 application.py