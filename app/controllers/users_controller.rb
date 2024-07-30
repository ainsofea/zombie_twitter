class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end  

  def create
    @user = User.new(user_params)
    if @user.save
      Rails.logger.info "User successfully created: #{@user.inspect}"
      session[:user_id] = @user.id
      flash[:notice] = 'User was successfully created'
      redirect_to '/'
    else
      Rails.logger.error "User creation failed: #{@user.errors.full_messages}"
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :graveyard, :email, :password)
  end
end
