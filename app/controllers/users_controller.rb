class UsersController < ApplicationController
  def sign_up
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid email or password' }
    end
  end

  private

  def user_params
    params[:users].permit(:email, :password, :password_confirmation)
  end
end
