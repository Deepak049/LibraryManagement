class SessionsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
        user = User.find_by_email(params[:user][:email])

        # checking if the user is active
        if(user && !user.is_active)
            render json: {:errors => "Your account is disabled, contact Admin!"}, status: 403 and return
        end

        # sends back token and email as a response if authenticated
        if user && user.authenticate(params[:user][:password])
            if request.format.json?
                data = {
                token: user.authentication_token,
                email: user.email
                }
                render json: data, status: 201 and return
            end
        else
            render json: {:errors => "Please check your email/password!"}, status: 403 and return
        end
    end
end