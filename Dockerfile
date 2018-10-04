FROM ruby:2.5.1-alpine

RUN apk update && apk upgrade

RUN mkdir -p /hackernews
WORKDIR /hackernews

ADD Gemfile Gemfile.lock ./

RUN bundle install

ADD . ./

ENTRYPOINT ["ruby", "hackernews.rb"]
CMD ["flag", "number"]
