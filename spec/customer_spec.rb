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

  it 'gets its invoices from the engine'
end
