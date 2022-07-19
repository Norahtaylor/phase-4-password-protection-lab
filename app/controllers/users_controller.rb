class UsersController < ApplicationController

    def create 
        user = User.create(user_params)
        session[:user_id] = user.id
        render json: user, status: :created 
        # else  
        #     render json: {error: "Not authorized"}, status: :unauthorized  
    end 

    def show 
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
        render json: user, status: :ok
        else 
            render json: {error: "Not authorized"}, status: :unauthorized  
        end
    end  

    private 

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end 
end
