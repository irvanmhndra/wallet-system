class TransactionsController < ApplicationController
  before_action :authenticate_user

  def create
    from_wallet = Wallet.find_by(id: params[:from_wallet_id]) if params[:from_wallet_id].present?
    to_wallet = Wallet.find_by(id: params[:to_wallet_id]) if params[:to_wallet_id].present?
    amount = params[:amount].to_f

    ActiveRecord::Base.transaction do
      case params[:type]
      when "credit"
        raise "Target wallet must be present for credit" if to_wallet.nil?
        Transaction.create!(wallet: to_wallet, amount: amount, transaction_type: "credit")
      when "debit"
        raise "Source wallet must be present for debit" if from_wallet.nil?
        Transaction.create!(wallet: from_wallet, amount: -amount, transaction_type: "debit")
      when "transfer"
        raise "Both source and target wallets must be present for transfer" if from_wallet.nil? || to_wallet.nil?
        Transaction.create!(wallet: from_wallet, amount: -amount, transaction_type: "debit")
        Transaction.create!(wallet: to_wallet, amount: amount, transaction_type: "credit")
      else
        raise "Invalid transaction type"
      end
    end

    render json: { message: "Transaction successful" }, status: :ok

  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
