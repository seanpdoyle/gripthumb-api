class SongSerializer < ActiveModel::Serializer
  cached

  attributes :id,  :guid, :name, :artist_name

  has_many :parts
end