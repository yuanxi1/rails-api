module Api
    module V1
        class AuthenticationsController < ApplicationController
            skip_before_action :authenticate_user, only: [:login]

            #user login
            def login
                user = User.find_by(email: login_params[:email])
                if user && user.authenticate(login_params[:password])
                    #issue the token if user pass the authentication
                    payload = {user_id: user.id}
                    token = encode_token(payload) ##potential area for DRY improvement???
                    render json: {user: UserSerializer.new(user), JWTToken: token}, status: :accepted
                    # render json: {user: user, JWTToken: token}, status: :accepted
                else
                    render json: {failure: "Invalid email or password"}, status: :unauthorized
                end
            end            

            private

            def login_params
                params.require(:user).permit(:email, :password)
            end
        end
    end 
end 