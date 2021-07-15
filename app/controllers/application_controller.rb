class ApplicationController < ActionController::Base
    before_action :authenticate_user, :make_categories

    def authenticate_user
        return true unless session[:current_user_id].nil? 
        flash[:alert] = "You need to be logged in to acces the website"
        redirect_to user_login_path
    end

    def make_categories
        return if Category.all.any?
        Category.run_template
    end
end
