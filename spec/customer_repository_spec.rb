require 'spec_helper'

RSpec.describe CustomerRepository do
  include RepoHelpers

  describe 'can find customers by' do
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

    specify 'id' do
      assert_finds_by :id, has: [5, 6], missing: [7]
    end

    specify 'first_name' do
      assert_finds_by :first_name, has: %w[Jack Jill], missing: ['Jan']
    end

    specify 'last_name' do
      assert_finds_by :last_name, has: %w[wilson Park], missing: ['Turing']
    end
  end


  describe 'can find all customers by' do
    specify 'first_name'
    specify 'last_name'
  end
end
