class Hospital < ApplicationRecord
  enum state: StringEnum["active", "deleted"]

  has_many :appointments
  has_many :hospital_affiliations
  has_many :doctors, through: :hospital_affiliations
  has_many :doctor_schedules

  validates_presence_of :name
end
