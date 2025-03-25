class WalletsController < ApplicationController
  before_action :authenticate_user
  before_action :set_wallet

  def show
    render json: { balance: @wallet.balance }, status: :ok
  end

  private

  def set_wallet
    @wallet = @current_user.wallet
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Wallet not found" }, status: :not_found
  end
end
