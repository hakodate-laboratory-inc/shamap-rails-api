FROM ruby:2.5-alpine
RUN apk update && apk add --no-cache alpine-sdk postgresql-dev nodejs tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install -j4
