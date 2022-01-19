class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :bg_preference
end
