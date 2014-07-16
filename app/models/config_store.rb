class ConfigStore < ActiveRecord::Base
  class << self
    def [](key)
      fetch_pair(key)
    end

    def []=(key, value)
      store_pair(key, value)
    end

    private

    def store_pair(key, value)
      record = find_or_create_by(key: key) 
      record.value_type = value.class.to_s
      record.value = value.to_s
      record.save
    end

    def fetch_pair(key)
      if record = where(key: key).first
        cast_value(record.value_type, record.value.to_s)
      else
        nil
      end
    end

    def cast_value(type, value)
      case type
      when "Fixnum"
        value.to_i
      when "String"
        value
      when "Float"
        value.to_f
      when "TrueClass", "FalseClass"
        to_bool(value)
      else
        raise RuntimeError, "Unknown value type"
      end
    end

    def to_bool(value)
      return true if value == "true"
      return false if value == "false"
    end
  end
end
