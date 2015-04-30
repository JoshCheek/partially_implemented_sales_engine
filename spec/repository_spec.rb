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

  include RepoHelpers

  def repo_for(records)
    super records, MockRepository
  end

  it 'can be initialized with an array of hashes' do
    as = repo_for([{a: 1}, {a: 100}]).map(&:a)
    expect(as).to eq [1, 100]
  end

  it 'can be initialized with an array of records' do
    records = [MockRecord.new(:engine1, a: 100), MockRecord.new(:engine2, a: 200)]
    repo    = repo_for(records)
    expect(repo.map &:a).to eq [100, 200]
    # expect(repo.map &:engine).to eq [repo.]
  end

  it 'overrides inspect to avoid https://github.com/rspec/rspec-core/issues/1631' do
    repo = repo_for([{a: 123123}])
    expect(repo.inspect).to include 'MockRepository'
    expect(repo.inspect).to include '1 row'
    expect(repo.inspect).to_not include '@' # no ivars
  end

  it 'gives access to all the records' do
    repo = repo_for([{a: 1}, {a: 20}])
    expect(repo.all.to_a).to eq repo.to_a
  end

  it 'gives access to a random record' do
    repo = repo_for([{a: 1}, {a: 2}])
    as   = 1000.times.map { repo.random.a }.uniq.sort
    expect(as).to eq [1, 2]
  end
end
