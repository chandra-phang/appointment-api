require 'rails_helper'

RSpec.describe 'Items API' do
  let!(:doctor) { create(:user) }
  let(:doctor_id) { doctor.id }
  let!(:hospital) { create(:hospital) }
  let(:hospital_id) { hospital.id }
  let!(:schedule) do
    DoctorSchedule.create(
      doctor_id: doctor_id, hospital_id: hospital_id, start_time: "09:00:00",
      end_time: "17:00:00", day_of_week: [1, 2, 3, 4, 5]
    )
  end
  let(:id) { schedule.id }

  describe 'GET /doctors/:doctor_id/schedules' do
    before { get "/doctors/#{doctor_id}/schedules" }

    context 'when doctor exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all doctor schedules' do
        expect(json.size).to eq(1)
      end
    end

    context 'when doctor does not exist' do
      let(:doctor_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'GET /doctors/:doctor_id/schedules/:id' do
    before { get "/doctors/#{doctor_id}/schedules/#{id}" }

    context 'when doctor schedule exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the schedule' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when doctor schedule does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find DoctorSchedule/)
      end
    end
  end

  describe 'POST /doctors/:doctor_id/schedules' do
    let!(:new_doctor) { create(:user, id: 99) }
    let(:valid_attributes) do
      {
        hospital_id: hospital_id, start_time: "09:00:00", 
        end_time: "17:00:00", day_of_week: [1, 2, 3, 4, 5]
      }
    end

    context 'when request attributes are valid' do
      before do
        post "/doctors/#{new_doctor.id}/schedules", params: valid_attributes
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before do
        post "/doctors/#{new_doctor.id}/schedules", params: valid_attributes.slice(hospital_id)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Hospital must exist/)
      end
    end
  end

  describe 'PUT /doctors/:doctor_id/schedules/:id' do
    let(:valid_attributes) { { hospital_id: hospital_id } }

    before { put "/doctors/#{doctor_id}/schedules/#{id}", params: valid_attributes }

    context 'when schedule exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the schedule' do
        updated_schedule = DoctorSchedule.find(id)
        expect(updated_schedule.doctor_id).to eq(doctor_id)
      end
    end

    context 'when the schedule does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find DoctorSchedule/)
      end
    end
  end

  describe 'DELETE /doctors/:id' do
    before { delete "/doctors/#{doctor_id}/schedules/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
