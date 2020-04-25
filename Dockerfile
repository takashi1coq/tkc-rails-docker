FROM ruby:2.5
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client
RUN mkdir /tkc-rails-docker
WORKDIR /tkc-rails-docker
COPY Gemfile /tkc-rails-docker/Gemfile
COPY Gemfile.lock /tkc-rails-docker/Gemfile.lock
RUN bundle install --without production
COPY . /tkc-rails-docker

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
