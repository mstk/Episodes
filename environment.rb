require 'rubygems'
require 'bundler/setup'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-migrations'
require 'dm-types'
require 'haml'
require 'yaml'
require 'json'
require 'ostruct'

require 'sinatra' unless defined?(Sinatra)

configure do
  SiteConfig = OpenStruct.new(
                 :title => 'Episodes',
                 :author => 'Justin Le',
                 :url_base => 'http://localhost:4567/'
               )

  # load models
  require "#{File.dirname(__FILE__)}/lib/models"

  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/episodes.sqlite3")
  # DataMapper.setup(:default, (ENV["DATABASE_URL"] || "sqlite3:///#{File.expand_path(File.dirname(__FILE__))}/#{Sinatra::Base.environment}.db"))
  
  DataMapper::Model.raise_on_save_failure = true
  
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }
end
