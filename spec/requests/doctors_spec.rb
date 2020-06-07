require 'rails_helper'

RSpec.describe 'Doctor API', type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:headers) { valid_headers }

  describe 'GET /doctors' do
    before { get '/doctors', headers: headers }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /doctors/:id' do
    context 'when the record exists' do
      before { get "/doctors/#{user_id}", headers: headers }

      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get "/doctors/#{9999}", headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'POST /doctors' do
    let(:valid_attributes) do
      {
        name: 'Tony', email: 'tony@gmail.com', role: "patient", password: "foo",
        gender: "male", date_of_birth: Time.zone.now.to_date
      }
    end

    context 'when the request is valid' do
      before { post '/doctors', params: valid_attributes, headers: headers }

      it 'creates a user' do
        expect(json['name']).to eq('Tony')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/doctors', params: valid_attributes.slice!(:email), headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Email can't be blank/)
      end
    end
  end

  describe 'PUT /doctors/:id' do
    let(:valid_attributes) { { name: 'Peter' } }

    context 'when the record exists' do
      before { put "/doctors/#{user_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /doctors/:id' do
    before { delete "/doctors/#{user_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
