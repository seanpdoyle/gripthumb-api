class Song < ActiveRecord::Base
  has_many :parts

  def self.identify(code)
    MatchSong.with_code(code)
  end

  def sanitized_name
    name.gsub(/\(.*\)/, "").squish
  end

  def parentheses_in_name?
    ["(",")"].all?{|p| name.include?(p)}
  end
end
