module Cacheable
  extend ActiveSupport::Concern

  included do
    before_save :store_in_cache
  end

  def store_in_cache
    Rails.cache.write("#{self.class}:#{self.key}", "#{self.value_type}:#{self.value}")  
  end
  
  def fetch_from_cache
    Rails.cache.fetch("#{self.class}:#{self.key}")  
  end
end
