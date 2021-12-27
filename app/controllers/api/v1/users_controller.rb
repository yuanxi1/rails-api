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

    private 
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
