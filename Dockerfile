FROM ubuntu:xenial-20180525
MAINTAINER m9207216@gmail.com

# https://github.com/sameersbn/docker-ubuntu
RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y vim.tiny wget sudo net-tools ca-certificates unzip apt-transport-https
# && rm -rf /var/lib/apt/lists/*


# android_p9.0.0_2.2.0-ga_docs/Android_User's_Guide.pdf
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    uuid uuid-dev zlib1g-dev liblz-dev liblzo2-2 liblzo2-dev lzop git-core \
    curl u-boot-tools mtd-utils android-tools-fsutils openjdk-8-jdk \
    device-tree-compiler gdisk m4 libz-dev

# for locale-gen
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils locales

# for build aosp9
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y make build-essential bc zip
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y make rsync

# for add-apt-repository
# https://itsfoss.com/add-apt-repository-command-not-found/
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common

RUN rm -rf /var/lib/apt/lists/*

#patch cmake 3.13
ADD cmake-3.13.0-install.tgz /


#https://askubuntu.com/questions/1015398/cant-set-locales-ubuntu-16-04
RUN locale-gen en_US.UTF-8
RUN update-locale LC_ALL="en_US.UTF-8"

#bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

COPY gitconfig /root/.gitconfig
COPY ssh_config /root/.ssh/config

COPY utils/docker_entrypoint.sh /root/docker_entrypoint.sh
COPY utils/aosp_bashrc.sh /root/aosp_bashrc.sh
RUN mkdir -p /root/aosp
COPY utils/aosp-u1604/bash_logout /root/aosp/.bash_logout
COPY utils/aosp-u1604/bashrc /root/aosp/.bashrc
COPY utils/aosp-u1604/profile /root/aosp/.profile
RUN chmod +x /root/docker_entrypoint.sh
ENTRYPOINT ["/root/docker_entrypoint.sh"]
