class String
  def to_bool
    return true if self == "true"
    return false if self == "false"
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end
