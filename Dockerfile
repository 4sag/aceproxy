
# Version: 0.0.3

# Используем за основу контейнера Ubuntu 14.04 LTS
FROM ubuntu:14.04

# Переключаем Ubuntu в неинтерактивный режим — чтобы избежать лишних запросов
ENV DEBIAN_FRONTEND noninteractive 

# Устанавливаем локаль
RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales

# Устанавливаем время
RUN echo Asia/Yekaterinburg >/etc/timezone && dpkg-reconfigure -f noninteractive tzdata 

# Добавляем необходимые репозитарии и устанавливаем пакеты
RUN apt-get update
