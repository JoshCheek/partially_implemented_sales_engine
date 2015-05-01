require 'spec_helper'

RSpec.describe Customer do
  include RecordHelpers

  it 'has in integer id' do
    assert_attribute :id, 1, 1
    assert_attribute :id, '1', 1
  end

  it 'has a first_name' do
    assert_attribute :first_name, 'Willy', 'Willy'
  end

  it 'has a last_name' do
    assert_attribute :last_name, 'Wonka', 'Wonka'
  end

  describe 'relationships' do
    include SalesEngineHelpers
    it 'allows access to its invoices' do
      engine = engine_for({
        customers: [{id: 1}, {id: 2}],
        invoices:  [
          {id: 100, customer_id: 2},
          {id: 200, customer_id: 1},
          {id: 300, customer_id: 2},
        ],
      })
      customer1, customer2 = engine.customer_repository.all
      expect(customer1.invoices.map &:id).to eq [200]
      expect(customer2.invoices.map &:id).to eq [100, 300]
    end

    it 'allows access to its transactions' do
      engine = engine_for({
        customers: [{id: 1}, {id: 2}],
        invoices:  [
          {id: 100, customer_id: 2},
          {id: 200, customer_id: 1},
        ],
        transactions: [
          {id: 99, invoice_id: 100},
          {id: 88, invoice_id: 200},
          {id: 77, invoice_id: 300},
          {id: 66, invoice_id: 200},
        ]
      })
      customer = engine.customer_repository.first
      expect(customer.transactions.map &:id).to eq [88, 66]
    end
  end
end
