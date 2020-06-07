module StringEnum
  def self.[](*values)
    values.reduce({}) { |hash, value| hash.merge!(value => value) }
  end
end
