class V1::SessionsController < ApplicationController

  include Authenticated

  skip_before_action :authenticate, only: [:create]

  def create
    @user = User.find_by(email: user_params[:email])
    if @user.try(:authenticate, user_params[:password])
      @user.generate_auth_token!
      render json: @user, status: :created
    else
      render_error InvalidCredentialsError
    end
  end

  def destroy
    auth_token.try(:destroy)
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
