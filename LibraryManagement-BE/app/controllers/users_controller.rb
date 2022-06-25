class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    def show
        # only admin can access other users account
        if(@user.is_admin)
            render json: User.find(params[:id])
        else
            render json: {:errors => "Access Denied"}, status: 400
        end
    end

    def index
        user = User.find_by_email(params[:email]) if params[:email]
        if(!user && @user.is_admin)
            # listing all the users for admin
            render json: User.all.order(created_at: :desc)
        else
            render json: user
        end
    end
    
    def create
        first_name = params[:user][:first_name]
        last_name = params[:user][:last_name]
        email = params[:user][:email]
        address = params[:user][:address]
        password = params[:user][:password]
        password_confirmation = params[:user][:password_confirmation]

        user = User.new(
            first_name: first_name, 
            last_name: last_name, 
            email: email, 
            address: address,
            password: password,
            password_confirmation: password_confirmation
        )

        if(params[:user][:wallet])
            user.wallet = params[:user][:wallet]
        end

        if user.save()
            render json: user, status: 200
        else
            render json: {:errors => user.errors.full_messages}, status: 400
        end
    end

    def update
        user = User.find(params[:id])

        # seperating admin update and user's profile update
        if(@user.is_admin)
            return admin_user_update(user)
        else
            return user_update(user)
        end
    end

    def admin_user_update(user)
        user.first_name = params[:user][:first_name] if params[:user][:first_name]
        user.last_name = params[:user][:last_name] if params[:user][:last_name]
        user.address = params[:user][:address] if params[:user][:address]
        user.wallet = params[:user][:wallet] if params[:user][:wallet]
        user.is_admin = params[:user][:is_admin] if params[:user][:is_admin]
        user.is_active = params[:user][:is_active] if params[:user][:is_active]
        
        if(params[:user][:password])
            user.password = params[:user][:password]
        end

        if user.save()
            render json: user, status: 200 and return
        else
            render json: {:errors => user.errors.full_messages}, status: 400 and return
        end
    end

    def user_update(user)
        user.first_name = params[:user][:first_name] if params[:user][:first_name]
        user.last_name = params[:user][:last_name] if params[:user][:last_name]
        user.address = params[:user][:address] if params[:user][:address]
        if(params[:user][:password])
            return change_password(user)
        end

        if user.save()
            render json: user, status: 200 and return
        else
            render json: {:errors => user.errors.full_messages}, status: 400 and return
        end
    end

    def change_password(user)
        # users can change password only if they know the current password
        if(user.authenticate(params[:user][:old_password]))
            user.password = params[:user][:password]
            user.password_confirmation = params[:user][:password_confirmation]
            
            if user.save()
                render json: user, status: 200 and return
            else
                render json: {:errors => user.errors.full_messages}, status: 400 and return
            end
        else
            render json: {:errors => "Old Password is not correct!"}, status: 400 and return
        end
    end

    def destroy
        # admin can disable the user
        if(@user.is_admin)
            user = User.find(params[:id])
            user.is_active = false
            user.save()
            render json: user, status: 200
        else
            render json: {:errors => "Access Denied"}, status: 400
        end
    end
end