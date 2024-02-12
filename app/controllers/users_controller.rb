class UsersController < ApplicationController

    def index
        @user = current_user
    end
    
    def new
        @user = User.new
    end
      
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            @user.award_welcome_bonus
            flash[:notice] = "User successfully created!"
            redirect_to users_path
        else
            flash.now[:alert] = "User not created. Try again."
            render :new, status: :unprocessable_entity
        end
    end

    def transfer
        recipient = User.find_by(id: params[:recipient_id])
        amount = BigDecimal(params[:amount])
        if recipient && amount > 0 && current_user.available_cash >= amount
            if current_user.transfer_cash(recipient, amount)
                flash[:notice] = "Transfer successfully completed!"
            else
                flash[:alert] = "Transfer not completed."
            end
        else
            flash[:alert] = "User not found."
        end
        redirect_to users_path
    end

    private 

    def user_params
        params.require(:user).permit(:name, :lastname, :email, :password, :password_confirmation)
    end
end
