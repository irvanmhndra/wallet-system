class ApplicationController < ActionController::API
  private

  def authenticate_user
    authorization_header = request.headers["Authorization"] # Should be "Bearer YOUR TOKEN"
    token = authorization_header.split(" ").last

    @current_user = User.find_by(token: token)

    if @current_user.nil? || !@current_user.token_valid?
      render json: { error: "Unauthorized or Token Expired" }, status: :unauthorized
    end
  end
end
