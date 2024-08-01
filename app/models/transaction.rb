class Transaction < ApplicationRecord
  belongs_to :bank_account

  validates :amount, presence: true
  validates :transaction_type, presence: true


  scope :by_type, ->(type) { where(transaction_type: type) if type.present? }
  scope :by_min_amount, ->(min_amount) { where(amount: min_amount..) if min_amount.present? }
  scope :by_max_amount, ->(max_amount) { where(amount: ..max_amount) if max_amount.present? }
  scope :by_start_date, ->(start_date) { where(created_at: Date.parse(start_date)..) if start_date.present? }
  scope :by_end_date, ->(end_date) { where(created_at: ..Date.parse(end_date).end_of_day) if end_date.present? }
  scope :sorted_by, ->(sort_column, sort_direction) { order("#{sort_column} #{sort_direction}") }
end
