FROM dockerfile/dart

RUN apt-get update
RUN apt-get install -yq build-essential openssl libreadline6 libreadline6-dev curl git-core \
    zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev \
    autoconf libc6-dev ncurses-dev automake libtool bison subversion libmysqlclient-dev

RUN cd /tmp && curl ftp://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz | tar xz
RUN cd /tmp/ruby-2.1.3 && ./configure --disable-install-rdoc && make && sudo make install
RUN rm -rf /tmp/ruby-2.1.3
RUN sudo gem install bundler --no-ri --no-rdoc
