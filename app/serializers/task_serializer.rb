class TaskSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description
  # has_many :tags, serializer: TagSerializer
  attribute :tag_list do |object|
    object.tags
  end
end
