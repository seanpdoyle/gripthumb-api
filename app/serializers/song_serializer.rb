class SongSerializer < ActiveModel::Serializer
  cached

  attributes :id,  :name, :artist_name

  has_many :parts
end