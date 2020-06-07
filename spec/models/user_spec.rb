require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:patient_appointments) }
  it { should have_many(:doctor_appointments) }
  it { should have_many(:doctor_schedules) }
  it { should have_many(:hospital_affiliations) }
  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
end
