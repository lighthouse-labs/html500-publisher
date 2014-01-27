if ENV['RACK_ENV'] == 'development'
  require 'dotenv'
  Dotenv.load
end

require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/user'