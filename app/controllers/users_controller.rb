require "digest"

class UsersController < ApplicationController
  before_action :authenticate_user, only: [ :sign_out ]

  def sign_up
    user = User.create(email: params[:email], password: Digest::SHA256.hexdigest(params[:password]))

    if user.persisted?
      render json: { message: "User created successfully", user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Sign In - Login user
  def sign_in
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      user.generate_auth_token
      user.save
      render json: {
        message: "Login successful",
        user_id: user.id,
        email: user.email,
        token: user.token,
        expires_at: user.expires_at
      }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # Sign Out - Logout user
  def sign_out
    if @current_user
      @current_user.update(token: nil, expires_at: nil)

      render json: {
        message: "Sign out successful",
        user_id: @current_user.id,
        email: @current_user.email
      }, status: :ok
    else
      render json: { error: "User not found or already signed out" }, status: :not_found
    end
  end
end
