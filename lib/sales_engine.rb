require 'csv'
require_relative 'customer_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :customer_repository, :invoice_repository

  def initialize(dir)
    @dir = dir
  end

  def startup
    @customer_repository = CustomerRepository.new self, data_for('customers')
    @invoice_repository  = InvoiceRepository.new  self, data_for('invoices')
  end

  private

  def data_for(table)
    csv_data = File.read File.join(@dir, "#{table}.csv")
    CSV.parse csv_data, headers: true, header_converters: :symbol
  end
end
