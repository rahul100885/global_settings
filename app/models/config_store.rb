class ConfigStore < ActiveRecord::Base
  # include Cacheable
  
  # store value in cache
  before_save :store_in_cache

  def store_in_cache
    Rails.cache.write("ConfigStore:#{self.key}", "#{self.value_type}:#{self.value}")  
  end

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
      # search key in cache
      # if exist then return it
      if cache_value = Rails.cache.fetch("ConfigStore:#{key}")
        value_type, value = cache_value.split(':')
        return cast_value(value_type, value)        
      end

      # fetch key from db
      # if key not found return nil
      if record = where(key: key).first
        cast_value(record.value_type, record.value.to_s)
      else
        nil
      end
    end

    # cast value into given type
    def cast_value(type, value)
      case type
      when "Fixnum"
        value.to_i
      when "String"
        value
      when "Float"
        value.to_f
      when "TrueClass", "FalseClass"
        to_boolean(value)
      else
        raise RuntimeError, "Unknown value type"
      end
    end

    # string to boolean 
    def to_boolean(value)
      return true if value == "true"
      return false if value == "false"
    end
  end
end
