class VideoSerializer < ActiveModel::Serializer
  cached

  attributes :id, :name, :logo

  def logo
    object.logo.url(:square)
  end
end