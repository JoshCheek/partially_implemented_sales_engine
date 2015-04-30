require_relative 'invoice'
require_relative 'repository'

class InvoiceRepository < Repository
  attr_accessor :all

  def initialize(engine, attr_hashes)
    self.all = attr_hashes.map { |hash| Invoice.new engine, hash }
  end

  def inspect
    'whatev'
  end

  def find_by_id(id)
    find_by id: id
  end

  def find_all_by_customer_id(customer_id)
    find_all_by customer_id: customer_id
  end

  def find_by(attributes)
    each_where(attributes) { |customer| return customer }
    nil
  end

  def find_all_by(attributes)
    each_where(attributes).to_a
  end

  def each_where(attributes)
    return to_enum :each_where, attributes unless block_given?
    all.each do |customer|
      if attributes.all? { |name, value| customer.match? name, value }
        yield customer
      end
    end
  end
end
