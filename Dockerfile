
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
RUN wget http://cloud.sybdata.com/AceStream/libgnutls-deb0-28_3.3.15-5ubuntu2_amd64.deb
RUN wget http://cloud.sybdata.com/AceStream/acestream-engine_3.0.5.1-0.2_amd64.deb
RUN apt-get update && apt-get install -y acestream-engine vlc-nox python-gevent supervisor unzip git gdebi
RUN gdebi libgnutls-deb0-28_3.3.15-5ubuntu2_amd64.deb
RUN gdebi acestream-engine_3.0.5.1-0.2_amd64.deb

#
RUN mkdir -p /var/log/supervisor
RUN adduser --disabled-password --gecos "" tv
RUN git clone https://github.com/AndreyPavlenko/aceproxy.git
RUN mv ./aceproxy /home/tv/aceproxy-master

RUN echo 'root:password' |chpasswd

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8000 8621 62062
VOLUME /etc/aceproxy

ENTRYPOINT ["/start.sh"]
