class RegistrationsController < Devise::RegistrationsController
  def create
    if User.find_by(email: params[:email])
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    else
      user = User.create(registration_params)
      token = user.generate_jwt
      render json: token.to_json
    end
  end

  private

  def registration_params
    params.permit(:email, :password, :password_confirmation)
  end
end
