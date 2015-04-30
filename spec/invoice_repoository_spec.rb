require 'spec_helper'

RSpec.describe InvoiceRepository do
  include RepoHelpers

  describe 'can find invoices by' do
    specify 'id' do
      assert_finds_by :id, has: [5, 6], missing: [7]
    end
  end

  describe 'can find all invoices by' do
    specify 'customer_id' do
      repo = repo_for [
        {id: 1, customer_id: 11},
        {id: 2, customer_id: 22},
        {id: 3, customer_id: 11},
      ]
      expect(repo.find_all_by_customer_id(11).map(&:id)).to eq [1, 3]
      expect(repo.find_all_by_customer_id(22).map(&:id)).to eq [2]
      expect(repo.find_all_by_customer_id(33).map(&:id)).to eq []
    end
  end
end
