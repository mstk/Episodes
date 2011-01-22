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
  haml :write
end

post '/save' do
  new_body = params[:new_body]
  type = params[:type]
  date = Date.parse(params[:date])
  
  raise "Bad type" unless %w{ day week month quarter year }.include? type
  
  @episode = Episode_Manager.EM(type.intern).current(date)
  
  @episode.update(:body => new_body)
end

post '/load' do
  type = params[:type] || 'day'
  date = params[:date] ? Date.parse(params[:date]) : Date.today
  
  raise "Bad type" unless %w{ day week month quarter year }.include? type
  
  if params[:mode] == 'current'
    @episode = Episode_Manager.EM(type.intern).current(date)
  else
    @episode = Episode_Manager.EM(type.intern).last_elapsed(date)
  end
  
  raise "Bad episode criteria" unless @episode
  
  @episode.to_json
end