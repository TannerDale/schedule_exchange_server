require 'rails_helper'

describe 'User Request' do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:data) { json[:data] }
  let(:attrs) { json[:data][:attributes] }

  describe 'GET /api/v1/users' do
    let!(:user) { create :user }

    context 'with valid user id' do
      before { get api_v1_users_path, params: { id: user.id } }

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

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

    context 'with invalid user id' do
      let(:bad_id) { user.id + 1 }

      before { get api_v1_users_path, params: { id: bad_id } }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns an error message' do
        expect(json[:message]).to eq 'Your query could not be completed'
      end

      it 'returns an appropriate error message' do
        expect(json[:error][:details]).to eq "Couldn't find User with 'id'=#{bad_id}"
      end
    end
  end

  describe 'POST /api/v1/users' do
    let!(:company) { create :company }
    let(:valid_params) do
      {
        first_name: 'Bobby',
        last_name: 'Rossle',
        email: 'bobbyrossle@email.com',
        password: 'hello',
        password_confirmation: 'hello',
        company_id: company.id
      }
    end

    context 'with valid params' do
      before { post api_v1_users_path, params: valid_params }

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end

      it 'creates the user' do
        expect(User.count).to eq 1
      end

      it 'returns the users id' do
        expect(data[:id]).to eq User.last.id.to_s
      end

      it 'returns user attributes' do
        expect(attrs[:first_name]).to eq 'Bobby'
      end
    end

    context 'with invalid params' do
      context 'invalid first name' do
        before :each do
          valid_params.delete(:first_name)

          post api_v1_users_path, params: valid_params
        end

        it 'returns status code 400' do
          expect(response).to have_http_status 400
        end

        it 'returns an appropriate error message' do
          expect(json[:error][:details]).to include "Validation failed: First name can't be blank"
        end
      end

      context 'invalid last name' do
        before :each do
          valid_params.delete(:last_name)

          post api_v1_users_path, params: valid_params
        end

        it 'returns status code 400' do
          expect(response).to have_http_status 400
        end

        it 'returns an appropriate error message' do
          expect(json[:error][:details]).to include "Validation failed: Last name can't be blank"
        end
      end

      context 'invalid email' do
        before :each do
          valid_params[:email] = 'asdfasdfasd'

          post api_v1_users_path, params: valid_params
        end

        it 'returns status code 400' do
          expect(response).to have_http_status 400
        end

        it 'returns an appropriate error message' do
          expect(json[:error][:details]).to include 'Validation failed: Email is invalid'
        end
      end

      context 'invalid password' do
        before :each do
          valid_params.delete(:password)

          post api_v1_users_path, params: valid_params
        end

        it 'returns status code 400' do
          expect(response).to have_http_status 400
        end

        it 'returns an appropriate error message' do
          expect(json[:error][:details]).to include "Validation failed: Password can't be blank"
        end
      end

      context 'invalid password confirmation' do
        let(:message) { "Validation failed: Password confirmation doesn't match Password" }

        before :each do
          valid_params[:password_confirmation] = 'asdfasdf'

          post api_v1_users_path, params: valid_params
        end

        it 'returns status code 400' do
          expect(response).to have_http_status 400
        end

        it 'returns an appropriate error message' do
          expect(json[:error][:details]).to include message
        end
      end
    end
  end
end
