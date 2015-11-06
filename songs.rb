require 'sinatra'
require 'dm-core'
require 'dm-migrations'


DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")


class Song
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :lyrics, Text
  property :length, Integer
  #property :released_on, Date
  #def released_on=date
   # super Date.strptime(date, '%m/%d/%Y')
  #end
end

DataMapper.finalize

first_time_run = false

if first_time_run
  puts "Create first song db"

  Song.auto_migrate!

  Song.create(title: "Come Fly With Me",
            lyrics: "Come fly with me, let's fly, let's fly away ... .",
            length: 199)
            #released_on: Date.new(1958,1,6))
  puts Song.count
  first_time_run = false
  abort "Initialized done"
end

get '/songs' do
  @songs = Song.all
  slim :songs
end

get '/songs/:id' do
  @song = Song.get(params[:id])
  slim :show_song
end

get '/songs/new' do
  @song = Song.new
  slim :new_song
end
get '/songs/:id' do
  @song = Song.get(params[:id])
  slim :show_song
end

post '/songs' do
  song = Song.create(params[:song])
  redirect to("/songs/#{song.id}")
end

get '/songs/:id/edit' do
  @song = Song.get(params[:id])
  slim :edit_song
end

put '/songs/:id' do
  song = Song.get(params[:id])
  song.update(params[:song])
  redirect to("/songs/#{song.id}")
end

delete '/songs/:id' do
  Song.get(params[:id]).destroy
  redirect to('/songs')
end

