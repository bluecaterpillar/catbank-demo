class ApplicationController < ActionController::Base
    protect_from_forgery

    private

    def current_user
        # Cashing the current user in an instance variable as it will probably get called often.
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    helper_method :current_user

    def authorize
        redirect_to login_url, alert: "User is not authorized" if current_user.nil?
    end
end
