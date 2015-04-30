require_relative '../lib/sales_engine'

module RecordHelpers
  def engine
    :fake_engine
  end

  def customer_for(attributes)
    described_class.new(engine, attributes)
  end

  def assert_attribute(name, input, output)
    customer = customer_for(name => input)
    expect(customer[name]).to eq output
  end
end

module RepoHelpers
  def repo_for(records, repo_klass=described_class)
    repo_klass.new(:fake_engine, records)
  end

  def assert_finds_by(attribute, has:, missing:)
    attr_hashes = has.map { |val| {attribute => val} }
    repo        = repo_for attr_hashes

    has.each do |expected|
      record = repo.__send__ "find_by_#{attribute}", expected
      actual = record.__send__ attribute
      expect(actual).to eq expected
    end

    missing.each do |val|
      record = repo.__send__ "find_by_#{attribute}", val
      expect(record).to eq nil
    end
  end
end
