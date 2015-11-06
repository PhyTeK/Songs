require 'sinatra'
require 'slim'
require 'sass'
require 'sinatra/static_assets'

#set :static, true
#set :root, File.dirname(__FILE__)

get('/styles.css'){ scss :styles }

get '/' do
  slim :home
end

get '/about' do
  @title = "All About This Website"
  slim :about
end

get '/contact' do
  slim :contact
end

not_found do
  slim :not_found
end