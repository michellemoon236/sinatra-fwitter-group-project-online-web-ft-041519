class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else 
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      tweet = Tweet.create(:content => params[:content])
      tweet.user_id = session[:user_id]
      tweet.save
      redirect to "/tweets"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do  #load edit form
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == session[:user_id]
          erb :'tweets/edit'
        else
          redirect '/tweets'
        end
    else 
      redirect '/login'
    end
  end

  patch '/tweets/:id' do #edit action
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else    
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end


  delete '/tweets/:id' do #delete action
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == session[:user_id]
      @tweet.delete
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

end
