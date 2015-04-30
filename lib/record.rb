class Record
  RecordError       = Class.new StandardError
  UnknownAttribute  = Class.new RecordError
  UnknownConversion = Class.new RecordError

  def self.conversions
    @conversions ||= Hash.new
  end

  def self.attribute(key, conversion=:none)
    conversions[key] = conversion
    define_method(key) { self[key] }
  end

  def initialize(engine, attributes)
    self.engine     = engine
    self.attributes = attributes
  end

  def match?(key, value)
    self[key] == value
  end

  def [](key)
    value = attributes[key]

    conversion_type = self.class.conversions.fetch key do
      raise UnknownAttribute, "Not an attribute! #{key.inspect}"
    end

    case conversion_type
    when :to_i
      value.to_i
    when :none
      value
    else
      raise UnknownConversion, "No conversion type for #{conversion_type.inspect}"
    end
  end

  private

  attr_accessor :engine, :attributes
end
