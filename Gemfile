
source 'https://rubygems.org'

ruby '2.1.0'
gem 'rails', '4.0.2'

# gem 'thin'

group :development do
  gem 'sqlite3'
  gem 'capistrano'
end

group :production do
  gem 'pg'
  gem 'execjs'
end

# https://github.com/heroku/rails_12factor
gem 'rails_12factor'

# https://github.com/redis-store/redis-rails
gem 'redis-rails'

# https://github.com/rgrove/sanitize
gem 'sanitize'

gem 'therubyracer', platforms: :ruby

# https://github.com/yaroslav/russian/
gem 'russian'

gem 'sass-rails',   '~> 4.0.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem "shoulda-matchers"
  gem 'database_cleaner'
  gem 'capybara'
  gem 'webrat'
  gem 'launchy'
end