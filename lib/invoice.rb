require_relative 'record'

class Invoice < Record
  attribute :id,          :to_i
  attribute :customer_id, :to_i
end
