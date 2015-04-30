require_relative 'customer'
require_relative 'repository'

class CustomerRepository < Repository
  def self.record_class
    Customer
  end

  def find_by_id(id)
    find_by id: id
  end

  def find_by_last_name(last_name)
    find_by last_name: last_name
  end

  def find_all_by_first_name(first_name)
    find_all_by first_name: first_name
  end
end
