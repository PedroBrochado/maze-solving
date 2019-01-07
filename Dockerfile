FROM ruby

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

RUN gem install bundler

WORKDIR /app

COPY Gemfile /app/Gemfile
RUN bundle

COPY . /app