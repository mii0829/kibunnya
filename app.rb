require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'

enable :sessions

before do 
    user = User.create(
        name: "ゲスト",
        password: "abc123"
    )
    user.save
end

get '/' do
  @contents = Post.all
  @feeling = Feeling.all
  erb :index
end

get '/signin' do
    erb :signin
end 

post '/signin' do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
        redirect '/home'
    else
        erb :index
    end 
end 

get '/signup' do
    erb :signup
end 

post '/signup' do
    user = User.create(
        name: params[:name],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
    )
    if user.persisted?
        session[:user] = user.id
    end 
    redirect '/home'
end 

helpers do 
    def current_user
        User.find_by(id: session[:user])
    end 
end 

get '/signout' do
    session[:user] = nil
    redirect'/'
end 

get '/signin/guest' do
    @contents = Post.all
    user = User.find_by(name: "ゲスト")
    if user 
        session[:user] = user.id
        redirect '/home'
    end 
    erb :home
end 

get '/search' do
    @contents = Post.all
    @feeling = Feeling.all
  erb :search
end 

get '/posts/new' do
  @feeling = Feeling.all
  erb :new
end

post '/post' do
    Post.create({
        title: params[:title],
        comment: params[:comment],
        feeling_id: params[:feeling]
    })
    @contents = Post.all
    @feeling = Feeling.all
    erb :home
end 

get '/home' do
  @contents = Post.all
  erb :home
 end 
 
 get '/feeling/:id' do
    @contents = Post.where(feeling_id: params[:id])
    @feeling = Feeling.all
    @feel = Feeling.find(params[:id])
    @feel_name = @feel.name
    @posts = @feel.posts
    erb :search
 end 
 
 get '/back' do
     erb :index
 end 
 
 get '/post/:post_id/like' do
     this_post = Post.find(params[:post_id])
     like = Like.new(user_id: session[:user],post_id: params[:post_id])
     like.save
     @contents = Post.all
     @feeling = Feeling.all
     erb :search
 end 
 
 get '/post/:post_id/like/delete' do
     this_post = Post.find(params[:post_id])
     like = Like.find_by(user_id: session[:user],post_id: params[:post_id])
     like.delete
     @contents = Post.all
     @feeling = Feeling.all
     erb :search
 end 
 
 get '/mypage' do
    @contents = Post.all
    @liked_posts = Like.all
    erb :mypage
 end 