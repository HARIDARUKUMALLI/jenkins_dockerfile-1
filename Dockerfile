FROM jenkins/jenkins:lts

USER root
RUN apt-get update
RUN apt-get install -y python3-pip
RUN apt-get install -y maven
# Install app dependencies
RUN pip3 install --upgrade pip

# set home directory for jenkins
ENV JENKINS_HOME /var/jenkins_home

# add user jenkins 
# this image already has user jenkins
# RUN useradd -d "$JENKINS_HOME" -u 102 -m -s /bin/bash jenkins 

# Create docker group with gid = 497 and add jenkins to the group
# This will allow the jenkins user to run docker commands
RUN groupadd -g 497 docker && \
    usermod -a -G docker jenkins

# Install the docker client
RUN apt-get install -y docker

# Jenkins home directoy is a volume, so configuration and build history 
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home
