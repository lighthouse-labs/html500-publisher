require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/user'

configure do 
  set :server, :puma 
  set :database, ENV['DATABASE_URL'] || "sqlite3:///db/dev.db"
end

get '/' do
  "Users: #{User.count}"
end
