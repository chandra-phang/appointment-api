class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.string_enum(*strings)
    strings.map { |s| [s, s] }.to_h
  end
end
