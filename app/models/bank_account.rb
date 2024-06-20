class BankAccount < ApplicationRecord
  acts_as_paranoid
  belongs_to :client
  has_many :transactions, dependent: :destroy
end
