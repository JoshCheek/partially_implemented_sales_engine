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
