require 'rails_helper'

RSpec.describe 'Appointment API' do
  let!(:doctor) { create(:user) }
  let!(:patient) { create(:user, role: :patient) }
  let!(:hospital) { create(:hospital) }
  let!(:schedule) do
    DoctorSchedule.create(
      doctor_id: doctor.id, hospital_id: hospital.id,
      day_of_week: [0, 1, 2, 3, 4, 5, 6],
      start_time: "09:00:00", end_time: "17:00:00"
    )
  end
  let!(:appointment) do
    Appointment.create(
      doctor_id: doctor.id, hospital_id: hospital.id, patient_id: patient.id,
      start_at: "2199-01-01 09:00:00", end_at: "2199-01-01 11:00:00"
    )
  end
  let(:id) { appointment.id }

  describe 'GET /appointments' do
    before { get "/appointments" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns all doctor appointments' do
      expect(json.size).to eq(1)
    end
  end

  describe 'GET /appointments/:id' do
    before { get "/appointments/#{id}" }

    context 'when appointment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the appointment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when appointment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end

  describe 'POST /appointments' do
    let!(:new_doctor) { create(:user, id: 99) }
    let(:valid_attributes) do
      {
        doctor_id: doctor.id, hospital_id: hospital.id, patient_id: patient.id,
        start_at: "2199-01-01 09:00:00", end_at: "2199-01-01 11:00:00"
      }
    end

    context 'when request attributes are valid' do
      before do
        post "/appointments", params: valid_attributes
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before do
        post "/appointments", params: valid_attributes.slice!(:hospital_id)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Hospital must exist/)
      end
    end
  end

  describe 'PUT /appointments/:id' do
    let(:valid_attributes) { { hospital_id: hospital.id } }

    before { put "/appointments/#{id}", params: valid_attributes }

    context 'when appointment exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the appointment' do
        updated_appointment = Appointment.find(id)
        expect(updated_appointment.doctor_id).to eq(doctor.id)
      end
    end

    context 'when the appointment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end

  describe 'DELETE /doctors/:id' do
    before { delete "/appointments/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
