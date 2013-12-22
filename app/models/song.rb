class Song < ActiveRecord::Base
  has_many :parts

  def self.identify(code)
    IdentifiesSong.with_code(code)
  end
end
