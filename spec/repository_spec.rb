require 'spec_helper'

RSpec.describe Repository do
  class MockRecord < Record
    attribute :a
  end

  class MockRepository < Repository
    def self.record_class
      MockRecord
    end
  end

  def repo_for(records)
    MockRepository.new(:fake_engine, records)
  end

  it 'can be initialized with an array of hashes' do
    as = repo_for([{a: 1}, {a: 100}]).map(&:a)
    expect(as).to eq [1, 100]
  end

  it 'can be initialized with an array of records'
  it 'overrides inspect to avoid https://github.com/rspec/rspec-core/issues/1631'
  it 'gives access to all the records'
  it 'gives access to a random record'
  it 'allows records to be searched by id'
end
