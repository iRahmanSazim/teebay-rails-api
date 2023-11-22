class ProductSerializer < Panko::Serializer
  attributes :id, :user_id, :title, :price, :description
  has_one :user, serializer: UserSerializer
end