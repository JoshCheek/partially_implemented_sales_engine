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

  require_relative '../lib/simple_sales_engine'
  def engine_for(repo_data)
    SimpleSalesEngine.new(repo_data).startup
  end

  describe 'relationships' do
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
  end
end
