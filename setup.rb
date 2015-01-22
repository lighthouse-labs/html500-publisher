ENV['RACK_ENV'] ||= 'development' # default to development

## LOAD
# if ENV['RACK_ENV'] == 'development'
require 'dotenv'
Dotenv.load
# end

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/content_for'
require 'sinatra/json'
require 'slim'
require 'fog'

require_relative 'models/user'

## CONFIGURE

configure do 
  # "Me like Puma" - KV 2014
  set :server, :puma 

  set(:database, ENV['DATABASE_URL']) if ENV['DATABASE_URL'].present?
  enable :sessions

  # Don't want secret key changing with every app restart
  set :session_secret, ENV['SESSION_KEY']

  # "Me like Slim" - KV 2014
  Slim::Engine.set_default_options pretty: true, sort_attrs: false
end
