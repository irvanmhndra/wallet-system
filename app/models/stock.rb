class Stock < ApplicationRecord
  has_one :wallet, as: :owner, dependent: :destroy
end
