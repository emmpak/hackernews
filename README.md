# Hacker News Parser

[![Build Status](https://travis-ci.org/emmpak/hackernews.svg?branch=master)](https://travis-ci.com/emmpak/hackernews)
[![Coverage Status](https://coveralls.io/repos/github/emmpak/hackernews/badge.svg?branch=master)](https://coveralls.io/github/emmpak/hackernews?branch=master)

A simple command line application which uses [Hacker News API](https://github.com/HackerNews/API) to get details for up to a 100 of the top posts.

### Setup

###### Clone repository

* Clone repository
* `cd` to the project's root directory

###### Use Docker (preferred way)

This is the preferred way to use the application as you don't have to worry about setup of your local environment and minimize software installations. 

Head to the [Docker website](https://docs.docker.com/install/#supported-platforms) and download the installation for your platform.

* Run `docker build -t hackernews .` to build the image (note that this might take a few minutes if you don't haven't previously downloaded the base images)
* Run `docker run hackernews --posts 5` to build the container and run the application to see the top 5 posts from Hacker News

 
###### Use Ruby installation

* Install ruby on your machine. For Windows, you can find some information [here](https://rubyinstaller.org/). If you are on Mac, I suggest you install [Homewbrew](https://brew.sh/)(a package management system) and run `brew install ruby`.
* Run `gem install bundler`
* Run `bundle install` to install all of the required gems
* Run `ruby hackernews.rb --posts 5` to see the top 5 posts from Hacker News


###### Libraries

* [Faraday](https://github.com/lostisland/faraday) - HTTP library used for connecting to the API. 
* [RSpec](https://github.com/rspec/rspec) - Testing framework used for TDD of the application.
* [Webmock](https://github.com/bblimke/webmock) - Library used for stubbing HTTP requests to avoid hitting the API during development and testing.
 




