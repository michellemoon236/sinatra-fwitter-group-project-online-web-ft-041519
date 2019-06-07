class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end
  
  post '/signup' do
    if params[:username] == "" || params[:email] =="" || params[:password] ==""
      redirect "/signup"
    else 
      User.create(username: params[:username], email: params[:email], password: params[:password])
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
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect "/login"
    end
  end
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
