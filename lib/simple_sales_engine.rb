require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'

class SimpleSalesEngine
  def initialize(repo_data={})
    @repo_data = repo_data
  end

  def startup(repo_data=@repo_data)
    @repos = {
      customer_repository:    repo_for(repo_data, :customers),
      invoice_repository:     repo_for(repo_data, :invoices),
      transaction_repository: repo_for(repo_data, :transactions),
    }
    self
  end

  def customer_repository
    repos.fetch :customer_repository
  end

  def invoice_repository
    repos.fetch :invoice_repository
  end

  def transaction_repository
    repos.fetch :transaction_repository
  end

  private

  attr_reader :repos

  def repo_for(repo_data, collection_name)
    record_attributes = repo_data.fetch collection_name, []
    repo_class = case collection_name
    when :customers    then CustomerRepository
    when :invoices     then InvoiceRepository
    when :transactions then TransactionRepository
    else raise "No known repository for #{collection_name.inspect}"
    end
    repo_class.new self, record_attributes
  end
end
