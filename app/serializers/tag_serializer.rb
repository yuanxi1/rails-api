class TagSerializer
  include JSONAPI::Serializer
  attributes :name, :id
end
