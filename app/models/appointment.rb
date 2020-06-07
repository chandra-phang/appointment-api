class Appointment < ApplicationRecord
  include TimeUtil

  belongs_to :doctor, class_name: "User", foreign_key: "doctor_id"
  belongs_to :patient, class_name: "User", foreign_key: "patient_id"
  belongs_to :hospital

  validates_presence_of :doctor_id, :patient_id, :hospital_id, :start_at, :end_at
  validate :start_at_smaller_than_end_at
  validate :fit_doctor_schedule
  validate :created_30_minutes_before_doctor_schedule_start
  validate :not_exceed_10_appointments

  scope :active, -> { where("end_at > ?", Time.zone.now) }
  scope :doctor, -> (doctor_id) { where(doctor_id: doctor_id) }

  def start_at_smaller_than_end_at
    if start_at.present? && end_at.present?
      errors.add(:start_at, "must be earlier than end_at") if start_at > end_at
    end
  end

  def fit_doctor_schedule
    valid = false
    (doctor&.doctor_schedules || []).each do |s|
      next if hospital_id != s.hospital_id

      start_at = self.start_at&.to_datetime
      end_at = self.end_at&.to_datetime

      next unless s.day_of_week.include?(start_at&.wday)
      
      start_date = start_at.beginning_of_day
      schedule_start_at = new_datetime(start_date, Time.parse(s.start_time))
      schedule_end_at = new_datetime(start_date, Time.parse(s.end_time))

      range = schedule_start_at..schedule_end_at
      valid = true if range.cover?(start_at) && range.cover?(end_at)
    end

    errors.add(:start_at, "please input valid doctor schedule") unless valid
  end

  def created_30_minutes_before_doctor_schedule_start
    valid = false
    (doctor&.doctor_schedules || []).each do |s|
      next if hospital_id != s.hospital_id

      start_at = self.start_at&.to_datetime
      next unless s.day_of_week.include?(start_at&.wday)
      
      start_date = start_at.beginning_of_day
      schedule_start_at = new_datetime(start_date, Time.parse(s.start_time))
      valid = true if (schedule_start_at.utc - Time.zone.now) >= 1800
    end

    errors.add(:start_at, "appointment should created minimal 30 minutes before schedule") unless valid
  end

  def not_exceed_10_appointments
    if Appointment.active.doctor(doctor_id).count >= 10
      errors.add(:doctor_id, "Sorry, the doctor has reach maximal number of appoinment")
    end
  end
end
