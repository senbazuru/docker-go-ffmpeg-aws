FROM centos:centos7
MAINTAINER senbazuru

# prepare
RUN yum -y update && yum clean all
RUN yum -y install epel-release

# install golang
RUN curl "https://storage.googleapis.com/golang/go1.20.5.linux-amd64.tar.gz" > "/opt/go1.20.5.linux-amd64.tar.gz"
RUN tar -C /usr/local -xzf /opt/go1.20.5.linux-amd64.tar.gz

# set PATH
RUN echo "export GOPATH=/go" > /etc/profile.d/gopath.sh
RUN echo "export PATH=$GOPATH/bin:/usr/local/go/bin/:$PATH" >> /etc/profile.d/gopath.sh
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# add libs
RUN rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
RUN yum -y install —enable-repo=nux-dextop,epel git gcc libjpeg-turbo-devel ffmpeg-devel python3

# install aws cli
RUN curl "https://bootstrap.pypa.io/pip/3.6/get-pip.py" -o "/tmp/get-pip.py"
RUN python3 /tmp/get-pip.py
RUN pip install awscli

