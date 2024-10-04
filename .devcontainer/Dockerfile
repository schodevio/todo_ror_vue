# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.2.2
FROM ghcr.io/rails/devcontainer/images/ruby:$RUBY_VERSION

# --- Custom setup
RUN apt-get update && \
    apt-get install -y imagemagick libmagickwand-dev

USER vscode
RUN git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

RUN sed -ir 's/plugins=(git)/plugins=(git bundler zsh-autosuggestions)/g' ~/.zshrc && \
    sudo chsh -s $(which zsh) $(whoami)
# ---
