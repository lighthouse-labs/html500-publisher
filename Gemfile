# A sample Gemfile
source "https://rubygems.org"

gem 'sinatra'
gem 'sinatra-activerecord'

gem 'puma'

group :development, :test do 
  gem 'shotgun'
  gem 'tux'
  gem 'sqlite3'
  gem 'dotenv' # heroku has config vars so doesnt use this
end

group :production do 
  gem 'pg'
end
