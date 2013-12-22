source 'https://rubygems.org'

gem 'rails', '4.0.2'

gem 'active_model_serializers'
gem 'inherited_resources', github: 'josevalim/inherited_resources'
gem 'has_scope'
gem 'pg'
gem 'nestling', path: "~/src/nestling"#github: 'gripthumb/nestling'
gem 'unicorn'

group :development, :test do
  gem 'dotenv-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
end

group :development do
  gem 'foreman'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '>= 2.14'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.6.7'
  gem 'rails_12factor'
end
