require_relative 'setup'

# Homepage - Where users will login
# Note: redirect to upload page if already logged in
get '/' do
  if current_user.present?
    redirect '/upload'
  else
    @user = User.new
    slim :index
  end
end

# Login page - Passwordless login
# Note: redirect to upload page if already logged in
post '/login' do
  @user = User.authenticate(params[:user])
  if @user.valid?
    session[:user_id] = @user.id
    redirect '/upload'
  else
    slim :index
  end
end

# Drag&Drop AJAX based mult-file uploader on this page
get '/upload' do
  current_user
  slim :upload
end

post '/upload' do 
  timestamp = Time.now.utc.to_i
  folder = "#{current_user.username}/#{timestamp}"
  upload_files(folder, params[:files])
  current_user.update_attributes folder: folder
  json site: current_user.username
end

get '/sites' do 
  # list all the sites
end

# display site for provided username
get '/site/:site' do 
  @user = User.with_site(params[:site])
  if @user
    slim :site, layout: false
  else
    'Site Not Found'
  end
end

private

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

def upload_files(folder, files)
  connection = Fog::Storage.new({
    :provider                 => 'AWS',
    :aws_access_key_id        => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key    => ENV['AWS_SECRET_ACCESS_KEY']
  })

  bucket = connection.directories.get(ENV['S3_BUCKET'])
  # directory = bucket.directories.create()

   # Upload to S3
  files.each do |file|
    bucket.files.create(
      key:    "#{folder}/#{file[:filename]}",
      body:   file[:tempfile].read,
      public: true
    )
  end
end


