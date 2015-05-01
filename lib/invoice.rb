require_relative 'record'

class Invoice < Record
  attribute :id,          :to_i
  attribute :customer_id, :to_i

  def transactions
    engine.transaction_repository.find_all_by_invoice_id id
  end
end
