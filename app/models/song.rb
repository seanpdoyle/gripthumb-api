class Song < ActiveRecord::Base
  has_many :parts

  def self.identify(code, identify = nil)
    MatchSong.new(code, identify).call
  end

  def sanitized_name
    name.gsub(/\(.*\)/, "").squish
  end

  def parentheses_in_name?
    ["(",")"].all?{|p| name.include?(p)}
  end
end
