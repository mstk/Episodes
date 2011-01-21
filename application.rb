require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require_relative 'environment'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

# root page
get '/' do
  haml :root
end

get '/write' do
  @curr_episode = Episode_Manager.EM(:day).last_elapsed
  haml :write
end

post '/write' do
  new_body = params[:episode_body]
  type = params[:type]
  date = Date.parse(params[:date])
  
  raise "Bad type" unless %{ day week month quarter year }.include? type
  
  @curr_episode = Episode_Manager.EM(type.intern).current(date)
  
  @curr_episode.update(:body => new_body)
  
  haml :write
end