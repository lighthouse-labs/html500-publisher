require_relative 'setup'

configure do 
  set :server, :puma 
  set :database, ENV['DATABASE_URL'] || "sqlite3:///db/dev.db"
end

get '/' do
  "Users: #{User.count}"
end
