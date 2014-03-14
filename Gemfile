source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.2'

gem 'active_model_serializers'
gem 'inherited_resources', github: 'josevalim/inherited_resources'
gem 'has_scope'
gem 'paperclip'
gem 'pg'
gem 'nestling', github: 'gripthumb/nestling'
gem 'nokogiri'
gem 'okcomputer'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: false
gem 'unicorn'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'dotenv-rails'
  gem 'fdoc'
  gem 'pry'
end

group :development do
  gem 'foreman'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '>= 2.14'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock', '~> 1.16'
end

group :staging, :production do
  gem 'autoscaler'
  gem 'aws-sdk'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end
