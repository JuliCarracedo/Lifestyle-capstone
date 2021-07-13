class ApplicationController < ActionController::Base
    before_action :authenticate_user

    def authenticate_user
        return true unless session[:current_user_id].nil? 
        flash[:alert] = "You need to be logged in to acces the website"
        redirect_to user_login_path
    end
end
