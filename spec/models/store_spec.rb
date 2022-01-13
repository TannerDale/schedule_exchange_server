require 'rails_helper'

describe Store do
  describe 'validations' do
    let!(:store) { create :store }

    it { should validate_presence_of :street_address }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :store_number }
    it { should validate_uniqueness_of(:store_number).scoped_to :company_id }
  end

  describe 'relationships' do
    it { should belong_to :company }
  end
end
