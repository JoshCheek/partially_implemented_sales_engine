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
end
