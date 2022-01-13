require 'rails_helper'

describe Store do
  describe 'validations' do
    let!(:company) { create :company }
    let!(:store) { Store.create(street_address: '123', zip_code: 1, store_number: 1, company_id: company.id) }

    it { should validate_presence_of :street_address }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :store_number }
    it { should validate_uniqueness_of(:store_number).scoped_to :company_id }
  end

  describe 'relationships' do
    it { should belong_to :company }
  end
end
