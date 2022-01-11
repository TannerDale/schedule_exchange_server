require 'rails_helper'

describe Company do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :password }
  end

  describe 'relationships' do
    it { should have_many :users }
  end
end
