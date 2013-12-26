class VideoSerializer < ActiveModel::Serializer
  cached

  attributes :id,  :name
end