FROM jenkins/jenkins:lts

USER root

# Установка зависимостей для Docker
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    lsb-release \
    && curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh \
    && rm get-docker.sh

# Добавление пользователя Jenkins в группу Docker
RUN usermod -aG docker jenkins
