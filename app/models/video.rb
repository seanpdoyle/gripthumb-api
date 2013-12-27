class Video < ActiveRecord::Base
  has_many :parts
  has_many :songs, through: :parts

  has_attached_file :logo, styles: { square: "100x100#" },
    default_url: "/videos/:style/missing.jpg"

  validates_attachment :logo,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
