class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:create, :edit, :update, :destroy]

  def index
    @tweet = Tweet.new
    @tweets = Tweet.order(created_at: :desc).limit(20)
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = session[:user_id]

    if @tweet.save
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to tweets_path, notice: 'Tweet published.'}
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_tweet", partial: "tweets/form", locals: { tweet: @tweet})}
        format.html { render :new }  
    end
  end
end

  def edit
    @tweet = Tweet.find(params[:id])
    render :edit    
  end

  def update
    @tweet = Tweet.find(params[:id])
    #respond_to do |format|
      if @tweet.update(tweet_params)
        redirect_to tweets_path, notice: 'Tweet updated.'
        #format.html { redirect_to(@tweet, notice => 'Post updated')  }
      else
        render :edit

        #format.html{ render :action => 'edit' }
      end
    #end

    #if @tweet.update(tweet_params)
     # redirect_to tweets_path, notice: 'Tweet was successfully updated.'
    #else
    #  render :edit
    #end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_path, notice: 'Tweet deleted.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@tweet) }
    end
    # redirect_to tweets_path, notice: 'Tweet was successfully destroyed.'
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:status, :user_id)
  end

  def authenticate_user
    redirect_to login_path, alert: 'You must be logged in to perform this action' unless session[:user_id]
  end
end
