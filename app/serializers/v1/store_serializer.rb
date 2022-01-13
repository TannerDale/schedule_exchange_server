class V1::StoreSerializer
  include JSONAPI::Serializer

  attributes :street_address, :zip_code, :store_number
  belongs_to :company
end
