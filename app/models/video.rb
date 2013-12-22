class Video < ActiveRecord::Base
  has_many :parts
  has_many :songs, through: :parts
end
