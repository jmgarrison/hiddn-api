class V1::UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      @user.generate_auth_token!
      render json: @user, status: :created
    else
      render json: @user, status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name,
                                 :password, :password_confirmation)
  end

end
