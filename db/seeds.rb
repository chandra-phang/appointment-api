include TimeUtil

HospitalAffiliation.destroy_all
DoctorSchedule.destroy_all
Appointment.destroy_all
User.destroy_all
Hospital.destroy_all

# Seed User
# =========

user_params = [
  {
    name: "Tony",
    state: "active",
    email: "tony@gmail.com",
    role: "patient",
    gender: "male",
    date_of_birth: "1990-01-01 00:00:00"
  },
  {
    name: "Steve",
    state: "active",
    email: "steve@gmail.com",
    role: "patient",
    gender: "male",
    date_of_birth: "1990-01-01 00:00:00"
  },
  {
    name: "Bruce",
    state: "active",
    email: "bruce@gmail.com",
    role: "patient",
    gender: "male",
    date_of_birth: "1990-01-01 00:00:00"
  },
  {
    name: "Strange",
    state: "active",
    email: "strange@gmail.com",
    role: "doctor",
    gender: "male",
    date_of_birth: "1990-01-01 00:00:00"
  },
  {
    name: "Dolittle",
    state: "active",
    email: "dolittle@gmail.com",
    role: "doctor",
    gender: "male",
    date_of_birth: "1990-01-01 00:00:00"
  }
]
User.create!(user_params)
doctor_ids = User.last(2).map(&:id)
patient_id = User.last(5).first.id

puts "Successfully seeding User"

# Seed Hospital
# =============

hospital_params = [
  {
    name: "Strange Care Hospital",
    state: "active"
  },
  {
    name: "Dolittle Animal Hospital",
    state: "active"
  }
]
Hospital.create!(hospital_params)
hospital_ids = Hospital.last(2).map(&:id)

puts "Successfully seeding Hospital"

# Seed HospitalAffiliation
# ========================

hospital_affiliation_params = [
  {
    doctor_id: doctor_ids[0],
    hospital_id: hospital_ids[0]
  },
  {
    doctor_id: doctor_ids[1],
    hospital_id: hospital_ids[1]
  }
]
HospitalAffiliation.create!(hospital_affiliation_params)
hospital_affiliations = HospitalAffiliation.last(2)

puts "Successfully seeding HospitalAffiliation"

# Seed DoctorSchedule
# ===================
doctor_schedule_params = hospital_affiliations.map do |affiliation|
  {
    doctor_id: affiliation[:doctor_id],
    hospital_id: affiliation[:hospital_id],
    day_of_week: [1, 2, 3, 4, 5],
    start_time: "09:00:00",
    end_time: "17:00:00"
  }
end
DoctorSchedule.create!(doctor_schedule_params)

puts "Successfully seeding DoctorSchedule"

# Seed Appointment
# ================

date = (Date.current + (1.week)).beginning_of_week.beginning_of_day
appointment_params = hospital_affiliations.map do |affiliation|
  {
    doctor_id: affiliation[:doctor_id],
    hospital_id: affiliation[:hospital_id],
    patient_id: patient_id,
    start_at: new_datetime(date, Time.parse("10:00:00")),
    end_at: new_datetime(date, Time.parse("11:00:00"))
  }
end

puts "Successfully seeding Appointment"