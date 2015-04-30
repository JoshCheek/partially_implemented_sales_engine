require 'spec_helper'

RSpec.describe CustomerRepository do
  include RepoHelpers

  describe 'can find customers by' do
    specify 'id' do
      repo = repo_for([{id: 5}, {id: 6}])
      expect(repo.find_by_id(5).id).to eq 5
      expect(repo.find_by_id(6).id).to eq 6
      expect(repo.find_by_id 7    ).to eq nil
    end

    specify 'first_name' do
      repo = repo_for([
        {first_name: 'Jack'},
        {first_name: 'Jill'},
      ])
      expect(repo.find_by_first_name("Jack").first_name).to eq "Jack"
      expect(repo.find_by_first_name("Jill").first_name).to eq "Jill"
      expect(repo.find_by_first_name "Jan"             ).to eq nil
    end

    specify 'last_name' do
      repo = repo_for([
        {last_name: 'Wilson'},
        {last_name: 'Park'},
      ])
      expect(repo.find_by_last_name("Wilson").last_name).to eq "Wilson"
      expect(repo.find_by_last_name("Park"  ).last_name).to eq "Park"
      expect(repo.find_by_last_name "Turing"           ).to eq nil
    end
  end

  describe 'can find all customers by' do
    specify 'first_name'
    specify 'last_name'
  end
end
