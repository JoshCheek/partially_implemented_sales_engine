require_relative 'record'

class Transaction < Record
  attribute :id
  attribute :invoice_id
end
