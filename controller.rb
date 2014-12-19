require 'sinatra'
require 'data_mapper'
require 'digest'
load 'models.rb'

# VIEW ROUTES
get '/' do
  erb :write_post
end

get '/register_account' do
  erb :register_account
end

get '/write_post' do
  erb :write_post
end
post '/write_comment' do
  erb :write_comment
end
get '/list' do 
  @posts = Post.all

  erb :list
end

# BACKEND CONTROLLERS
post '/account/new' do
  account = Account.create params
  
  redirect '/list'
end

post '/post/like' do 
  post = Post.get params[:post_id]
  post.likes.create

  redirect '/list'
end
post '/post/new' do
  Post.create params

  redirect '/list'
end
post '/post/comment/new' do 
  post = Post.get params[:post_id]
  post.comments.create(
    :body => params[:body])

  redirect '/list'
end

