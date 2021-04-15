require 'sinatra/base'
require_relative './lib/bookmark.rb'
require './database_connection_setup.rb'
require 'uri'
require 'sinatra/flash'
require_relative './lib/comment'
require_relative './lib/user.rb'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
  register Sinatra::Flash 

  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    @user = User.find(session[:user_id])
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  get '/bookmarks/new' do 
    erb :new
  end

  post '/bookmarks' do 
    flash[:notice] = "You must submit a valid URL." unless Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do 
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do 
    @bookmark = Bookmark.find(id: params[:id])
    erb :edit
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect('/bookmarks')
  end


  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :new_comment
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  get '/users/new' do 
    erb :new_user
  end

  post '/users' do 
    User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/bookmarks'
  end

  run! if app_file == $0
end