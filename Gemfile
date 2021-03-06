source 'https://rubygems.org'

gem 'pg'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'

gem 'rbnacl'
gem 'rbnacl-libsodium'

gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'rails_param', :git => 'https://github.com/vadimstroganov/rails_param.git'

gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
gem 'aescrypt'

gem 'pg_query'
gem 'pghero'
gem 'faker'

gem 'carrierwave', '~> 1.0'
gem 'carrierwave-base64'
gem 'carrierwave-imageoptimizer'
gem 'mini_magick'

gem 'font-awesome-rails'

gem 'ajax-datatables-rails'
gem 'bootstrap_form'
gem 'devise'

gem 'rpush'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'json-schema'
  gem 'rspec-rails', '~> 3.5'
end

group :test do
  gem 'database_cleaner'
  gem 'json_matchers'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'puma', '~> 3.0'
  gem 'rubocop', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # deploy tools
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-bundler', '~> 1.2'
  gem 'capistrano-db-tasks', '0.4', require: false
  gem 'capistrano-faster-assets', '~> 1.0'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rvm'
  gem 'capistrano-rpush'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
