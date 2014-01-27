require_relative 'setup'

get '/' do
  "Users: #{User.count}"
end
