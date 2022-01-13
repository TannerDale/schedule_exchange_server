require 'rails_helper'

describe 'Stores Request' do
  let!(:company) { create :company }

  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:data) { json[:data] }
  let(:attrs) { data[:attributes] }

  describe 'POST /api/v1/stores' do
    let(:store) { build :store, company_id: company.id }
    let(:valid_params) do
      {
        street_address: store.street_address,
        zip_code: store.zip_code,
        store_number: store.store_number,
        company_id: store.company_id
      }
    end

    context 'with valid params' do
      before { post api_v1_stores_path, params: valid_params }

      it 'creates the store' do
        expect(Store.count).to eq 1
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'with invalid params' do
      context 'invalid street address' do
        before :each do
          valid_params.delete(:street_address)
          post api_v1_stores_path, params: valid_params
        end

        it 'doesnt create the store' do
          expect(Store.count).to eq 0
        end

        it 'returns status code 400' do
          expect(response).to have_http_status 400
        end

        it 'returns a relevent error message' do
          expect(json[:error][:details]).to include('Street address')
        end
      end

      context 'invalid zip code' do
        before :each do
          valid_params.delete(:zip_code)
          post api_v1_stores_path, params: valid_params
        end

        it 'doesnt create the store' do
          expect(Store.count).to eq 0
        end

        it 'returns status code 400' do
          expect(response).to have_http_status 400
        end

        it 'returns a relevent error message' do
          expect(json[:error][:details]).to include('Zip code')
        end
      end

      context 'invalid store number' do
        before :each do
          valid_params.delete(:store_number)
          post api_v1_stores_path, params: valid_params
        end

        it 'doesnt create the store' do
          expect(Store.count).to eq 0
        end

        it 'returns status code 400' do
          expect(response).to have_http_status 400
        end

        it 'returns a relevent error message' do
          expect(json[:error][:details]).to include('Store number')
        end
      end

      context 'invalid company id' do
        before :each do
          valid_params[:company_id] = 0
          post api_v1_stores_path, params: valid_params
        end

        it 'doesnt create the store' do
          expect(Store.count).to eq 0
        end

        it 'returns status code 400' do
          expect(response).to have_http_status 400
        end

        it 'returns a relevent error message' do
          expect(json[:error][:details]).to include('Company')
        end
      end
    end
  end
end
