require_relative 'setup'

get '/' do
  # if session[:user_id].present?
  #   redirect '/upload'
  # else
  slim :index
  # end
end

post '/login' do
  @user = User.authenticate(params[:user])
  if @user.valid?
    session[:user_id] = @user.id
    redirect '/upload'
  else
    slim :index
  end
end

get '/upload' do
  'Upload page here'
end

get '/test_upload' do 
  connection = Fog::Storage.new({
    :provider                 => 'AWS',
    :aws_access_key_id        => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key    => ENV['AWS_SECRET_ACCESS_KEY']
  })

  bucket = connection.directories.get(ENV['S3_BUCKET'])

   # Upload to S3
  file = bucket.files.create(
    key:    'data.csv',
    body:   'hello,there',
    public: true
  )
end


