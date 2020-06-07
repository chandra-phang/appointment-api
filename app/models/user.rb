class User < ApplicationRecord
# encrypt password
  has_secure_password

  enum state: StringEnum["active", "deleted"]
  enum role: StringEnum["doctor", "patient"]
  enum gender: StringEnum["male", "female"]

  has_many :hospital_affiliations, foreign_key: "doctor_id"
  has_many :hostpitals, through: :hospital_affiliations
  has_many :doctor_schedules, foreign_key: "doctor_id"
  has_many :patient_appointments, class_name: "Appointment", foreign_key: "patient_id"
  has_many :doctor_appointments, class_name: "Appointment", foreign_key: "doctor_id"

  validates_presence_of :name, :email, :password_digest
  # validates_format_of :email, with:  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  validates_date :date_of_birth, allow_nil: true
end
