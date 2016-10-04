FROM ruby:2.3.1-alpine

MAINTAINER YoshinoriN

RUN apk update --no-cache \
  && apk add --no-cache mysql-client \
  && mkdir -p /usr/src/app

WORKDIR /usr/src/app
COPY . /usr/src/app
RUN bundle install --without development test

ENV RAILS_ENV production
RUN bundle exec rake db:create
RUN bundle exec rake db:migrate
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb", "-b", "0.0.0.0" ]
