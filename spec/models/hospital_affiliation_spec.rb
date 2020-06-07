require 'rails_helper'

RSpec.describe HospitalAffiliation, type: :model do
  # Association test
  it { should belong_to(:doctor) }
  it { should belong_to(:hospital) }
end
