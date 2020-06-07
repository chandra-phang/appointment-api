class DoctorSchedule < ApplicationRecord
  belongs_to :doctor, class_name: "User", foreign_key: "doctor_id"
  belongs_to :hospital

  validates_presence_of :start_time, :end_time, :day_of_week

  def start_at_by_date(date)
    
  end

  def end_at_by_date(date)
  end
end
