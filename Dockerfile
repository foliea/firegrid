FROM base/devel:latest

RUN echo '[archlinuxfr]' >> /etc/pacman.conf && \
    echo 'SigLevel = Never' >> /etc/pacman.conf && \
    echo 'Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf && \
    pacman -Syu --noconfirm \
        qt5 \
        xdotool \
        wget \
        crystal \
        shards

ENV CRYSTAL_VERSION=0.23.1 APP=/firegrid PATH="/crystal/bin:$PATH"

RUN wget https://github.com/crystal-lang/crystal/releases/download/$CRYSTAL_VERSION/crystal-$CRYSTAL_VERSION-3-linux-x86_64.tar.gz && \
    tar -xzvf crystal-$CRYSTAL_VERSION-3-linux-x86_64.tar.gz && \
    mv crystal-$CRYSTAL_VERSION-3 /crystal && \
    rm crystal-$CRYSTAL_VERSION-3-linux-x86_64.tar.gz


COPY shard.yml $APP/
COPY shard.lock $APP/

RUN useradd --create-home --home-dir $HOME dev && \
    chown -R dev:dev $HOME && \
    chown -R dev:dev $APP

USER dev

RUN cd $APP && crystal deps install

COPY . $APP

RUN ln -s $APP/config/firegrid.toml $HOME/.firegrid.toml

WORKDIR $APP
