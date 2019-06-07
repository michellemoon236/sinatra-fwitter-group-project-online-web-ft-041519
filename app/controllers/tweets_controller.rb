class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = current_user.tweets
      erb :'tweets/index'   
    else
      redirect '/login'
    end
      
  end
 
  get '/tweets/new' do
    erb :'tweets/new'
  end
  
  post '/tweets' do
    @tweet = Tweet.create(:content => params[:content])
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do  #load edit form
    @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit'
    end
 
  patch '/tweets/:id' do #edit action
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end


  delete '/tweets/:id' do #delete action
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect '/tweets'
  end

end
