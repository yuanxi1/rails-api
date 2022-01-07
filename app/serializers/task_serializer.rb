class TaskSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :completed, :duedate, :created_at
  # has_many :tags
  attribute :tag_list do |object|
    object.tags.map{ |tag| {
      name: tag.name,
      id: tag.id}
    }
    # TagSerializer.new(object.tags).as_json["data"].map(
    #   |tag| tag.attributes
    # )
  end
end
