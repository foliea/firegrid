FROM base/devel:latest

RUN pacman -Syu --noconfirm \
        qt5-base \
        ttf-dejavu \
        xdotool \
        wget \
        crystal \
        shards

ENV APP=/firegrid PATH="/crystal/bin:$PATH" XDG_RUNTIME_DIR=/tmp/runtime-dev

RUN wget https://github.com/crystal-lang/crystal/releases/download/v0.24.1/crystal-0.24.1-2-linux-x86_64.tar.gz && \
    tar -xzvf crystal-0.24.1-2-linux-x86_64.tar.gz && \
    mv crystal-0.24.1 /crystal && \
    rm crystal-0.24.1-2-linux-x86_64.tar.gz

COPY shard.yml $APP/
COPY shard.lock $APP/

RUN cd $APP && crystal deps install

COPY . $APP

RUN useradd --create-home --home-dir $HOME/dev dev && \
    mkdir $XDG_RUNTIME_DIR && \
    chown -R dev:dev $HOME && \
    chown -R dev:dev $APP && \
    chown -R dev:dev $XDG_RUNTIME_DIR

USER dev

WORKDIR $APP
