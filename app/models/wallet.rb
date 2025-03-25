class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :transactions

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def calculate_balance
    transactions.sum(:amount)
  end
end
