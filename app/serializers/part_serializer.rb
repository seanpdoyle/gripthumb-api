class PartSerializer < ActiveModel::Serializer
  cached

  attributes :id, :name

  has_one :video
end