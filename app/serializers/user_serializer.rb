class UserSerializer < Panko::Serializer
  attributes :id, :user_name, :email
  # has_many :products, serializer: ProductSerializer
end