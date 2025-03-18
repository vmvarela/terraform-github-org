FROM alpine:3.21

# Instalar dependencias necesarias
RUN apk update && apk add --no-cache \
    bash \
    curl \
    gcompat \
    git \
    github-cli \
    jq \
    libc6-compat \
    libstdc++ \
    make \
    nodejs \
    npm \
    oh-my-zsh \
    openssh \
    pre-commit \
    py3-pip \
    unzip \
    && rm -rf /var/cache/apk/* \
    && cp /usr/share/oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# Establecer directorio de trabajo
WORKDIR /workspace
