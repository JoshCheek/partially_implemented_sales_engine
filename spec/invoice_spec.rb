require 'spec_helper'

RSpec.describe Invoice do
  include RecordHelpers

  it 'has an integer id' do
    assert_attribute :id, 1, 1
    assert_attribute :id, '1', 1
  end

  it 'has an integer customer_id' do
    assert_attribute :customer_id, 1, 1
    assert_attribute :customer_id, '1', 1
  end

  describe 'relationships' do
    include SalesEngineHelpers
    it 'allows access to its transactions' do
      engine = engine_for({
        invoices:     [{id: 1}, {id: 2}],
        transactions: [
          {id: 100, invoice_id: 2},
          {id: 200, invoice_id: 1},
          {id: 300, invoice_id: 2},
        ],
      })
      invoice1, invoice2 = engine.invoice_repository.all
      expect(invoice1.transactions.map &:id).to eq [200]
      expect(invoice2.transactions.map &:id).to eq [100, 300]
    end
  end
end
