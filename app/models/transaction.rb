class Transaction < ApplicationRecord
  belongs_to :wallet

  validates :amount, numericality: { other_than: 0 }
  validates :transaction_type, inclusion: { in: %w[credit debit] }

  after_create :update_wallet_balance

  private

  def update_wallet_balance
    wallet.update(balance: wallet.calculate_balance)
  end
end
