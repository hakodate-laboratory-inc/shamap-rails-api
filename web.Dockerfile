FROM ruby:2.5-alpine
RUN apk update && apk add --no-cache alpine-sdk postgresql-dev nodejs tzdata imagemagick
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN mkdir /myapp
WORKDIR /myapp
