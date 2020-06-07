require 'rails_helper'

RSpec.describe Appointment, type: :model do
  # Association test
  it { should belong_to(:doctor) }
  it { should belong_to(:patient) }
  it { should belong_to(:hospital) }
  # Validation tests
  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }
end
