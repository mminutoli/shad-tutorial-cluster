FROM ubuntu:20.04
MAINTAINER Marco Minutoli <marco.minutoli@pnnl.gov>

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y openssh-server sudo build-essential libopenmpi-dev

RUN mkdir /var/run/sshd
RUN echo 'root:tutorial' | chpasswd
RUN echo 'PermitRootLogin yes' > /etc/ssh/sshd_config.d/root_login.conf

# Add a user for the tutorial
RUN adduser --disabled-password --gecos "" tutorial && \
    echo "tutorial ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/tutorial

# Setup Keys
RUN mkdir /home/tutorial/.ssh
ADD ssh/config /home/tutorial/.ssh/config
ADD ssh/id_rsa.mpi /home/tutorial/.ssh/id_rsa
ADD ssh/id_rsa.mpi.pub /home/tutorial/.ssh/id_rsa.pub
ADD ssh/id_rsa.mpi.pub /home/tutorial/.ssh/authorized_keys

RUN chmod -R 600 /home/tutorial/.ssh/* && \
    chown -R tutorial:tutorial /home/tutorial/.ssh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
