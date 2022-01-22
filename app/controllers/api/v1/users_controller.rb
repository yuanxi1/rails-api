class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticate_user, only: [:create]

    #user registration
    def create
        @user = User.new(user_params)

        if @user.save
            render status: 201
        else
            render json: {error: @user.errors.full_messages[0]}, status: 400
        end
    end
    def update
        user = User.find(params[:id])
        if user && user.authenticate(params[:user][:old_password])
            if user.update(resetpw_params)
                render status: 204
            else 
                render json: {error: "Unable to update password"}, status: 400
            end 
        else
            render json: {error: "Wrong password"}, status: 400
        end
    end
    def update_preference
        user = User.find(params[:id])
        
        if user.update(preference_params)
            render json: UserSerializer.new(user), status: 200
        else 
            render json: {error: user.errors.full_messages}, status: 400
        end 
       
    end

    private 
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
    def resetpw_params
        params.require(:user).permit(:password, :password_confirmation)
    end
    def preference_params
        params.require(:user).permit(:bg_preference)
    end
end
