class ApplicationController < ActionController::Base

    def require_user
        if !user_signed_in?
            flash[:danger] = "You Must Be logged in to perform that action"
            redirect_to root_path
        end
    end
end
