class ApplicationController < ActionController::API
    before_action :authenticate_user #authenticate every request

    def secret_key
        'my_secret'
    end

    def encode_token(payload)
        exp = 6.hours.from_now
        payload[:exp] = exp.to_i
        JWT.encode(payload, secret_key)
    end

    def auth_header
        request.headers['Authorization']
    end
    
    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, secret_key, true, algorithm: 'HS256')
            rescue JWT::DecodeError
                [{error: "Invalid Token"}]
            end
        end
    end
    

    def current_user
        if decoded_token        
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end
    
    def logged_in?
        !!current_user  
    end
    
    def authenticate_user
        if ! logged_in? 
            render json: {error: 'Please Login to proceed'}, status: 401 
        end

    end
end