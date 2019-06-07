class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end
  
  post '/signup' do
    if params[:username] == "" || params[:email] =="" || params[:password] ==""
      redirect "/signup"
    else 
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end 
  
  get '/login' do 
    if logged_in?
      redirect "/tweets" 
    else 
      erb :'users/login'
    end
  end
  
  post '/login' do
    #binding.pry
    @user = User.find_by(username: params[:username])
    #binding.pry
    if @user && @user.authenticate(params[:password])
      #binding.pry
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/tweets'
    end
  end
  
    get "/users/:slug" do
    # if logged_in?
      user = User.find_by_slug(params[:slug])
      @tweets = user.tweets
      erb :'/users/show'
    # else
    #   redirect '/login'
    # end
    
  end
end
