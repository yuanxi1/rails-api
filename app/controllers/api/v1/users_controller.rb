class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticate_user

    #user registration
    def create
        @user = User.new(user_params)

        if @user.save
            payload = {user_id: @user.id}
            token = encode_token(payload)
            render json: { user: UserSerializer.new(@user), JWTToken: token }, status: :created
        else
            render json: {errors: @user.errors.full_messages}, status: :not_acceptable
        end
    end
    def update
        user = User.find(params[:id])
        if user && user.authenticate(params[:user][:old_password])
            #issue the token if user pass the authentication
            if user.update(resetpw_params)
                payload = {user_id: user.id}
                token = encode_token(payload) ##potential area for DRY improvement???
                render json: {user: UserSerializer.new(user), JWTToken: token}, status: :ok
            else 
                render json: {errors: "Unable to update password"}, status: :unauthorized
            end # render json: {user: user, JWTToken: token}, status: :accepted
        else
            render json: {errors: "Invalid password"}, status: :unauthorized
        end
    end

    private 
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
    def resetpw_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end
