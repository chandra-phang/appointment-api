class User < ApplicationRecord
  enum state: StringEnum["active", "deleted"]
  enum role: StringEnum["doctor", "patient"]
  enum gender: StringEnum["male", "female"]

  has_many :hospital_affiliations, foreign_key: "doctor_id"
  has_many :hostpitals, through: :hospital_affiliations
  has_many :doctor_schedules, foreign_key: "doctor_id"
  has_many :patient_appointments, class_name: "Appointment", foreign_key: "patient_id"
  has_many :doctor_appointments, class_name: "Appointment", foreign_key: "doctor_id"

  validates_presence_of :name, :email
  validates_date :date_of_birth, allow_nil: true

  def generate_jwt
    JWT.encode(
      { id: id, exp: 60.days.from_now.to_i },
      Rails.application.secrets.secret_key_base
    )
  end
end
