class Api::V1::AuthController < ApiController
  before_action :authenticate_user!, only: :logout

  def signup
    user = User.new(auth_params)
    if user.save
      render json: {
        user_id: user.id
      }
    else
      render json: {
        message: "Failed",
        errors: user.errors
      }
    end
  end

  def login
    user = User.find_by_email(auth_params[:email])

    if !user
      render json: {
        message: "You should sign up first."
      }, status: 404
    end and return

    if !user.valid_password?(auth_params[:password])
      render json: {
        message: "Wrong password."
      }, status: 401
    end and return

    render json: {
      message: "ok",
      auth_token: user.token,
      user_id: user.id
    }
  end

  def logout
    current_user.generate_token
    current_user.save!

    render json: {
      message: "ok"
    }
  end

  private

  def auth_params
    params.permit(:email, :password)
  end

end
