require 'csv'
require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'simple_sales_engine'

class SalesEngine < SimpleSalesEngine
  def initialize(dir)
    @dir = dir
  end

  def startup
    super customers: data_for('customers'),
          invoices:  data_for('invoices')
  end

  private

  def data_for(table)
    csv_data = File.read File.join(@dir, "#{table}.csv")
    CSV.parse csv_data, headers: true, header_converters: :symbol
  end
end
