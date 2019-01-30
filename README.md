# ShaMAP

[![pipeline status](https://gitlab.com/shamap/shamap-rails-api/badges/master/pipeline.svg)](https://gitlab.com/shamap/shamap-rails-api/commits/master)
[![coverage report](https://gitlab.com/shamap/shamap-rails-api/badges/master/coverage.svg)](https://shamap.gitlab.io/shamap-rails-api/coverage/)

Share your map.

## Development
You have to execute like below at first.
```shell
cat <<EOF > .env
RAILS_MASTER_KEY="ask member"
SHAMAP_ADMINS=aiko.takamori@mishiro.pro,koume.shirasaka@mishiro.pro
EOF

# pre-commit
bundle exec pre-commit install
git config pre-commit.ruby "bundle exec ruby"
```

This project uses Docker, so you have to install [Docker](https://www.docker.com) ;)

```shell
docker-compose up
```
You can start to develop!


If you modify Gemfile, you have to execute below.
```shell
docker-compose build && docker-compose up
```
