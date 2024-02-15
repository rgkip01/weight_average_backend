FROM ruby:3.2.2-alpine AS base

CMD ["/bin/sh", "-c", "-set", "-uex"]

RUN apk update && apk add --no-cache \
    autoconf \
    bash \
    curl \
    build-base \
    dpkg-dev dpkg \
    git \ 
    mysql-client \
    mysql-dev \
    tzdata

FROM base AS release

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/Gemfile 
COPY Gemfile.lock /usr/src/app/Gemfile.lock

RUN gem update --system && bundle install

COPY . /usr/src/app

COPY docker-entrypoint.sh /usr/bin/

ENTRYPOINT [ "docker-entrypoint.sh" ]

EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]
