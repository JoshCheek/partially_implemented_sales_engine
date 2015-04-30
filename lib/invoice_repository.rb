require_relative 'invoice'
require_relative 'repository'

class InvoiceRepository < Repository
  def self.record_class
    Invoice
  end

  def find_by_id(id)
    find_by id: id
  end

  def find_all_by_customer_id(customer_id)
    find_all_by customer_id: customer_id
  end
end
