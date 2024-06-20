class TransactionDecorator < Draper::Decorator
  delegate_all

  def formatted_date
    object.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  def formatted_amount
    "#{object.amount} руб."
  end
end
