# Dockerfile
FROM ruby:3.3.6

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  pkg-config \
  postgresql-client \
  curl \
  && rm -rf /var/lib/apt/lists/*


RUN gem install rails

WORKDIR /app

# Si no existe Gemfile, crear nueva app Rails
RUN if [ ! -f Rakefile ]; then \
  rails new . --database=postgresql --css=tailwind --skip-bundle; \
fi

# Copy Gemfile
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy application code
COPY . .

RUN rm -f config/master.key

# Precompile assets
RUN bundle exec rails assets:precompile 2>/dev/null || true

# Expose port
EXPOSE 3000

# Start Rails
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000", "-e", "production"]
