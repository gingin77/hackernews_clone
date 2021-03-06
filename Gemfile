source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = '#{repo_name}/#{repo_name}' unless repo_name.include?('/')
  'https://github.com/#{repo_name}.git'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'devise'
gem 'bootstrap', '~> 4.0.0'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'dotenv-rails'

group :development, :test do
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-rails-collection', require: false
  gem 'capistrano-passenger', '~> 0.2.0', require: false
  gem 'capistrano-bundler', '~> 1.3', require: false
  # Use Puma as the app server
  gem 'puma', '~> 3.7'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.7'
  # Adds support for Capybara system testing and selenium driver
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'rails-controller-testing'
  gem 'launchy', '~> 2.4', '>= 2.4.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
