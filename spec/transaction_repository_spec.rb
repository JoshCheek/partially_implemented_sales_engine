RSpec.describe TransactionRepository do
  include RepoHelpers

  describe 'can find transactions by' do
    specify 'id' do
      assert_finds_by :id, has: [5, 6], missing: [7]
    end
  end

  describe 'can find all transactions by' do
    specify 'invoice_id' do
      repo = repo_for [
        {id: 1, invoice_id: 11},
        {id: 2, invoice_id: 22},
        {id: 3, invoice_id: 11},
      ]
      expect(repo.find_all_by_invoice_id(11).map(&:id)).to eq [1, 3]
      expect(repo.find_all_by_invoice_id(22).map(&:id)).to eq [2]
      expect(repo.find_all_by_invoice_id(33).map(&:id)).to eq []
    end
  end
end
