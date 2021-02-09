class ApplicationController < ActionController::Base
  respond_to :json
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  # def encode_token(payload)
  #   JWT.encode(payload, 's3cr3t')
  # end

end
