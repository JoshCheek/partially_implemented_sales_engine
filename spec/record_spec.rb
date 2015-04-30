require 'spec_helper'

RSpec.describe Record do
  def record_class(&definition)
    Class.new(described_class, &definition)
  end

  def engine
    :fake_engine
  end

  describe 'converting attributes to the correct type' do
    specify ':none conversion returns the value as found' do
      klass = record_class { attribute :a }
      expect(klass.new(engine, a:   1).a).to eq 1
      expect(klass.new(engine, a: '1').a).to eq '1'
    end

    specify ':none is the default' do
      conversion = record_class { attribute :a }.conversions[:a]
      expect(conversion).to eq :none
    end

    specify ':to_i conversion calls to_i' do
      klass = record_class { attribute :a, :to_i }
      expect(klass.new(engine, a:   1).a).to eq 1
      expect(klass.new(engine, a: '1').a).to eq 1
      expect(klass.new(engine, a: nil).a).to eq 0
    end
  end

  describe 'match?' do
    it 'returns true if the attribute is == after being converted' do
      klass = record_class { attribute :a, :to_i }

      as_int = klass.new engine, a: 11
      expect(as_int.match? :a, 11).to eq true
      expect(as_int.match? :a, 3).to eq false

      as_string = klass.new engine, a: '22'
      expect(as_string.match? :a, 22).to eq true
      expect(as_string.match? :a, 3).to eq false
    end

    it 'explodes if asked for an unknown attribute' do
      expect { record_class.new(engine, a: 1).match? :a, 1 }
        .to raise_error Record::UnknownAttribute, /:a/
    end

    it 'explodes if given an unknown conversion' do
      expect {
        klass    = record_class { attribute :a, :wat }
        instance = klass.new(engine, a: 1)
        instance.match? :a, 1
      }.to raise_error Record::UnknownConversion, /:wat/
    end
  end
end
