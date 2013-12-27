class Video < ActiveRecord::Base
  has_many :parts
  has_many :songs, through: :parts

  has_attached_file :logo, styles: { thumb: "200x200>", square: "200x200#" },
    path: ":rails_root/:class/:attachment/:id_partition/:filename",
    default_url: "/videos/:style/missing.jpg"

  validates_attachment :logo,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
