FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt update -y && apt upgrade -y
RUN apt install git -y
RUN apt-get install sudo -y
RUN apt install iproute2 -y
RUN apt-get install python3-distutils -y
RUN apt-get install iptables -y

RUN addgroup --gid 1000 stack && adduser --uid 1000 --ingroup stack --disabled-password stack
RUN adduser stack sudo
RUN echo "%stack ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN git clone https://opendev.org/openstack/devstack.git -b stable/wallaby
RUN chown -R stack:stack /devstack
RUN chmod 755 devstack

USER 1000
