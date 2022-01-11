require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe 'relationships' do
    it { should belong_to :company }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(%i[employee supervisor manager]) }
  end
end
