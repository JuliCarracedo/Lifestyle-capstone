class ApplicationController < ActionController::Base
    before_action :authenticate_user

    def authenticate_user
        !session[:current_user_id].nil?
    end
end
