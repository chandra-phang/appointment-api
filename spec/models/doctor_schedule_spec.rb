require 'rails_helper'

RSpec.describe DoctorSchedule, type: :model do
  # Association test
  it { should belong_to(:doctor) }
  it { should belong_to(:hospital) }
  # Validation tests
  it { should validate_presence_of(:day_of_week) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
end
