FROM ruby:2.5.3-alpine
RUN apk update && apk add --no-cache alpine-sdk postgresql-dev nodejs tzdata imagemagick
RUN gem install rails
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN mkdir /myapp
WORKDIR /myapp
