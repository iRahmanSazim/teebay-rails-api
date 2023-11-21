class ProductSerializer < Panko::Serializer
  attributes :id, :user_id, :title, :price, :description
end