require 'spec_helper'

RSpec.describe SimpleSalesEngine do
  it 'initializes its repositories with record data from the hashes it is initialized with' do
    engine = SimpleSalesEngine.new(
      customers:     [{first_name:  'a'}],
      invoices:      [{customer_id: 999}],
      transactions:  [{invoice_id:  888}],
      invoice_items: [{item_id:     777}],
      merchants:     [{name:        'b'}],
      items:         [{description: 'c'}],
    ).startup
    expect( engine.customer_repository     .map(&:first_name)  ).to eq ['a']
    expect( engine.invoice_repository      .map(&:customer_id) ).to eq [999]
    # expect( engine.transaction_repository  .map(&:invoice_id)  ).to eq [888]
    # expect( engine.invoice_item_repository .map(&:item_id)     ).to eq [777]
    # expect( engine.merchant_repository     .map(&:name)        ).to eq ['b']
    # expect( engine.item_repository         .map(&:description) ).to eq ['c']
  end

  it 'initialized its repositories with no records if the key is not present' do
    engine = SimpleSalesEngine.new.startup
    expect(engine.customer_repository     .all).to be_empty
    expect(engine.invoice_repository      .all).to be_empty
    # expect(engine.transaction_repository  .all).to be_empty
    # expect(engine.invoice_item_repository .all).to be_empty
    # expect(engine.merchant_repository     .all).to be_empty
    # expect(engine.item_repository         .all).to be_empty
  end
end
