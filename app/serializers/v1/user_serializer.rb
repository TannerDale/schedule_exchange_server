class V1::UserSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name, :email, :role
  belongs_to :company
end
