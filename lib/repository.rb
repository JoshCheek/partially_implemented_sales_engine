class Repository
  attr_accessor :all

  def initialize(engine, attr_hashes)
    self.all = attr_hashes.map do |hash|
      self.class.record_class.new engine, hash
    end
  end

  def record_class
    raise 'Implement me in subclasses!'
  end

  def inspect
    "#<#{self.class} #{all.count} rows>"
  end

  def random
    all.sample
  end

  def find_by_id(id)
    find_by id: id
  end

  private

  def find_by(attributes)
    each_where(attributes) { |customer| return customer }
    nil
  end

  def find_all_by(attributes)
    each_where(attributes).to_a
  end

  def each_where(attributes)
    return to_enum :each_where, attributes unless block_given?
    all.each do |customer|
      if attributes.all? { |name, value| customer.match? name, value }
        yield customer
      end
    end
  end
end
