class V1::CompanySerializer
  include JSONAPI::Serializer

  attributes :name
  has_many :users
end
