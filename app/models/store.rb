class Store < ApplicationRecord
  validates :street_address, presence: true
  validates :zip_code, presence: true
  validates :store_number, uniqueness: { scope: :company_id }, presence: true

  belongs_to :company
end
