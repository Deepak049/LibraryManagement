class ApplicationController < ActionController::Base
  # ensure every request is authenticated with token
  before_action :authenticate_user_from_token!

  private

  # checks if user available, active and token is valid
  def authenticate_user()
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      @user = user_email && User.find_by_email(user_email)
      unless @user && @user.is_active && Devise.secure_compare(@user.authentication_token, token)
        render json: {:msg => "Unauthorized"}, status: 401 and return
      end
    end

    if(!@user)
      render json: {:msg => "Unauthorized"}, status: 401 and return
    end
end

  def authenticate_user_from_token!
    # checks the request for token
    if(request.headers['Authorization'])
      authenticate_user()
    else
      render json: {:msg => "Unauthorized"}, status: 401 and return
    end
  end
end
