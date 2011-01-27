require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'digest/sha1'
require_relative 'environment'

enable :sessions

$salt = 'th1$ 1$ my $@1t'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

# root page
get '/' do
  haml :root
end

get '/write' do
  login_required
  haml :write
end

post '/save' do
  new_body = params[:new_body]
  type = params[:type]
  date = Date.parse(params[:date])
  
  raise "Bad type" unless %w{ day week month quarter year }.include? type
  
  @episode = current_user.episode_during_day(type.intern,date)
  
  @episode.update(:body => new_body)
end

post '/load' do
  type = params[:type] || 'day'
  date = params[:date] ? Date.parse(params[:date]) : Date.today
  
  raise "Bad type" unless %w{ day week month quarter year }.include? type
  
  if params[:mode] == 'current'
    @episode = current_user.episode_during_day(type.intern,date)
  else
    @episode = current_user.most_recent_episode(type.intern,date)
  end
  
  raise "Bad episode criteria" unless @episode
  
  @episode.to_json
end

get '/login' do
  haml :login
end

post '/login' do
  if user = User.authenticate(params[:username], params[:password])
    session[:user] = user.id
    redirect_to_stored
  else
    redirect '/login'
  end
end

get '/signup' do
  haml :signup
end

post '/signup' do
  @user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
  if @user.save
    session[:user] = @user.id
    redirect '/login'
  else
    redirect '/signup'
  end
end

get '/logout' do
  session[:user] = nil
  redirect '/'
end

get '/api.json' do
  login_required
  content_type "text/json"
  "{ 'a': 'b' }"
end

get '/test' do
  haml :test
end