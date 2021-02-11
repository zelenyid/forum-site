class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(params[:email])

    if user&.valid_password?(params[:password])
      token = user.generate_jwt
      render json: token.to_json
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end
