require 'rails_helper'

describe V1::UserSerializer do
  let(:user) { create :user }
  let(:json) { V1::UserSerializer.new(user).to_json }
  let(:parsed) { JSON.parse(json, symbolize_names: true) }
  let(:data) { parsed[:data] }
  let(:attrs) { data[:attributes] }

  it 'has a data key' do
    expect(parsed).to have_key :data
  end

  it 'has id and type' do
    expect(data[:id]).to eq user.id.to_s
    expect(data[:type]).to eq 'user'
  end

  it 'has the user attributes' do
    expect(attrs[:first_name]).to eq user.first_name
    expect(attrs[:last_name]).to eq user.last_name
    expect(attrs[:email]).to eq user.email
    expect(attrs[:role]).to eq user.role
  end

  it 'has the user relationships' do
    expect(data[:relationships][:company][:data][:id]).to eq user.company_id.to_s
    expect(data[:relationships][:company][:data][:type]).to eq 'company'
  end
end
