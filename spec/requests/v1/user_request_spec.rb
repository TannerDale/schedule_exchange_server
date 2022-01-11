require 'rails_helper'

describe 'User Request' do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:data) { json[:data] }
  let(:attrs) { json[:data][:attributes] }

  describe 'GET /api/v1/users' do
    let!(:user) { create :user }

    describe 'with valid user id' do
      before { get api_v1_users_path, params: { id: user.id }, headers: headers }

      it 'selects the requested user' do
        expect(data[:id]).to eq user.id.to_s
      end

      it 'returns the requested user atrtibutes' do
        expect(attrs[:first_name]).to eq user.first_name
        expect(attrs[:last_name]).to eq user.last_name
        expect(attrs[:email]).to eq user.email
        expect(attrs[:role]).to eq user.role
      end
    end

    describe 'with invalid user id' do
      let(:bad_id) { user.id + 1 }
      before { get api_v1_users_path, params: { id: bad_id } }

      it 'returns an error message' do
        expect(json[:message]).to eq 'Your query could not be completed'
      end

      it 'returns why the query faild' do
        expect(json[:error][:details]).to eq "Couldn't find User with 'id'=#{bad_id}"
      end
    end
  end
end
