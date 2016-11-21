
# Version: 0.0.1

# Используем за основу контейнера phusion/baseimage
FROM phusion/baseimage:latest

# Переключаем Ubuntu в неинтерактивный режим — чтобы избежать лишних запросов
ENV DEBIAN_FRONTEND noninteractive 

# Устанавливаем локаль
RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales

# Устанавливаем время
RUN echo Asia/Yekaterinburg >/etc/timezone && dpkg-reconfigure -f noninteractive tzdata 

# Добавляем необходимые репозитарии и устанавливаем пакеты
RUN apt-get update && apt-get install -y wget
RUN echo 'deb http://repo.acestream.org/ubuntu/ trusty main' > /etc/apt/sources.list.d/acestream.list
RUN wget -O - http://repo.acestream.org/keys/acestream.public.key | apt-key add -
RUN apt-get update && apt-get install -y acestream-engine vlc-nox python-gevent supervisor unzip git

#
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor
RUN adduser --disabled-password --gecos "" tv
RUN git clone https://github.com/AndreyPavlenko/aceproxy.git
RUN mv ./aceproxy /home/tv/aceproxy-master

RUN echo 'root:password' |chpasswd

