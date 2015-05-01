require_relative 'transaction'
require_relative 'repository'

class TransactionRepository < Repository
  def self.record_class
    Transaction
  end

  def find_by_id(id)
    find_by id: id
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by invoice_id: invoice_id
  end
end
