require_relative 'record'

class Customer < Record
  attribute :id, :to_i
  attribute :first_name
  attribute :last_name

  def invoices
    engine.invoice_repository.find_all_by_customer_id id
  end

  def transactions
    invoices.flat_map &:transactions
  end
end
