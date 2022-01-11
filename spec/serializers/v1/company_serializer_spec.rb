require 'rails_helper'

describe V1::CompanySerializer do
  let(:company) { create :company }
  let!(:user) { create :user, company_id: company.id }

  let(:json) { V1::CompanySerializer.new(company).to_json }
  let(:parsed) { JSON.parse(json, symbolize_names: true) }
  let(:data) { parsed[:data] }
  let(:attrs) { data[:attributes] }

  it 'has a data key' do
    expect(parsed).to have_key :data
  end

  it 'has id and type' do
    expect(data[:id]).to eq company.id.to_s
    expect(data[:type]).to eq 'company'
  end

  it 'has the company attributes' do
    expect(attrs[:name]).to eq company.name
  end

  it 'has the company relationships' do
    expect(data[:relationships][:users][:data].first[:id]).to eq user.id.to_s
    expect(data[:relationships][:users][:data].first[:type]).to eq 'user'
  end
end
