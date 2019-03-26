class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :auth_user_from_token!

  def auth_user_from_token!
    if params[:auth_token].present?
      user = User.find_by_token(params[:auth_token])
      sign_in(user, store: false) if user
    end
  end
end
