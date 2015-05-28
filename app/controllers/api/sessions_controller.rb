class Api::SessionsController < ApiController

  skip_before_action :authenticate_request, only: :create


  def create
    user = User.find_by_credentials(params[:credentials])

    if user.set_access_token
      render json: { auth_token: user.access_token  }
    else
      render json: { error: 'Incorrect email or password' }, status: :unauthorized
    end
  end

  def show
    fail ExpiredSessionError unless current_user
  end

  def destroy
    success = current_user.destroy_access_token
    render json: {success: true}
  end

end
