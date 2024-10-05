ARG DEBIAN_FRONTEND=noninteractive
FROM python:3.12.7-slim-bookworm AS devcontainer

RUN apt update -y \
    && apt upgrade -y

RUN apt install -y \
    build-essential \
    curl \
    git \
    sudo \
    zsh

# Install kubectl
RUN KUBECTL=/usr/local/bin/kubectl \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && mv kubectl $KUBECTL  \ 
    && chmod +x $KUBECTL

# Install Helm
RUN https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

RUN useradd -ms /bin/bash dev \
    && echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN chsh -s $(which zsh) $(whoami)
USER dev


# Install oh-my-zsh
ENV ZSH_CUSTOM=/home/dev/.oh-my-zsh/custom
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
RUN git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
RUN sed -i \
    's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-autocomplete kubectl python)/' \
    $HOME/.zshrc
RUN sed -i \
    's/ZSH_THEME="[^"]*"/ZSH_THEME="eastwood"/' \
    $HOME/.zshrc
WORKDIR /home/dev/workspace
CMD [ "sleep", "infinity" ]