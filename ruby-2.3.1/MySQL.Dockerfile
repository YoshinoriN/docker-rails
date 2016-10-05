FROM ruby:2.3.1-alpine

MAINTAINER YoshinoriN

RUN apk update --no-cache \
  && apk add --no-cache mysql-client \
  && mkdir -p /usr/src/app

WORKDIR /usr/src/app
COPY . /usr/src/app

ENV RAILS_ENV production

RUN bundle install --without development test \
  && bundle exec rake db:create \
  && bundle exec rake db:migrate \
  && bundle exec rake assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb", "-b", "0.0.0.0" ]
