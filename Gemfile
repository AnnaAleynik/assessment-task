source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem "rails", "~> 6.1.6", ">= 6.1.6.1"

gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"

gem "httparty"
gem "interactor"
gem "kaminari"

gem "jbuilder", "~> 2.7"
gem "sass-rails", ">= 6"
gem "slim-rails"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"

gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  gem "dotenv-rails"
  gem "pry"
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
end

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "database_cleaner-active_record"
end
