class UsersController < ApplicationController
  skip_before_action :authenticate_user
  def login
    @user = User.new
  end

  def create_session
    @user = User.find_by(name: params[:name])
    if params[:name].empty?
      flash[:alert] = 'Insert a username'
      redirect_to user_login_path
    elsif !@user
      flash[:alert] = 'User does not exist'
      redirect_to user_login_path
    else
      session[:current_user_id] = @user.id
      flash[:notice] = "#{@user.name} Successfully logged in"
      redirect_to articles_path
    end
  end

  def kill_session
    reset_session
    flash[:notice] = 'Successfully logged out'
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      flash[:notice] = "#{@user.name} Successfully logged in"
      redirect_to articles_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
