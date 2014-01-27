# A sample Gemfile
source "https://rubygems.org"

ruby '2.1.0'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-activerecord'

gem 'puma'
gem 'slim'

group :development, :test do 
  gem 'shotgun'
  gem 'tux'
  gem 'sqlite3'
  gem 'dotenv' # heroku has config vars so doesnt use this
end

group :production do 
  gem 'pg'
end
