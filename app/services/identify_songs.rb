class IdentifySongs
  KEYS = [:id, :artist_name, :title].freeze

  def initialize(code)
    @code = code
  end

  def call
    @songs ||= client.identify(version: 4.12, code: @code).map{|song_hash|
      if has_required_attributes?(song_hash)
        song_from_echoprint(song_hash)
      end
    }.reject(&:blank?)
  end

  private
    def song_from_echoprint(song_hash)
      Song.new(
        guid: song_hash[:id],
        artist_name: song_hash[:artist_name],
        name: song_hash[:title]
      )
    end

    def has_required_attributes?(song_hash)
      KEYS.all?{|k| song_hash.has_key?(k)}
    end

    def client
      Nestling.new.song
    end
end