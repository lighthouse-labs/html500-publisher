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

delete '/logout' do 
  session[:user_id] = nil
  redirect '/'
end

# Drag&Drop AJAX based mult-file uploader on this page
get '/upload' do
  if current_user.blank?
    redirect '/'
  else
    slim :upload  
  end
end

post '/upload' do 
  timestamp = Time.now.utc.to_i
  folder = "#{current_user.username}/#{timestamp}"
  upload_files(folder, params[:files], params[:relative_paths])
  file_name = get_html_filename(params[:files])
  current_user.update_attributes folder: folder, page: file_name
  json path: "#{current_user.username}/#{file_name}"
end

# display site for provided username
get '/site/:site/:file' do 
  @user = User.with_site(params[:site])
  @file = params[:file]
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

def get_html_filename(files)
  file = files.detect {|f| f[:filename] == 'index.html' } || 
    files.detect {|f| f[:filename].ends_with?('.html') }
  file[:filename] if file
end

def upload_files(folder, files, relative_paths)
  connection = Fog::Storage.new({
    :provider                 => 'AWS',
    :aws_access_key_id        => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key    => ENV['AWS_SECRET_ACCESS_KEY']
  })

  bucket = connection.directories.get(ENV['S3_BUCKET'])
  # directory = bucket.directories.create()


   # Upload to S3
  files.each_with_index do |file, i|
    relative_path = relative_paths[i]
    key = "#{folder}/#{relative_path}#{file[:filename]}"
    options = {
      key:    key,
      body:   file[:tempfile].read,
      public: true
    }
    options[:content_type] = 'image/svg+xml' if file[:filename].ends_with?('svg')
    bucket.files.create(options)
  end
end


