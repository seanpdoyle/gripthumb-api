class IdentifiesSong
  def self.with_code(code)
    IdentifySong.new(code).call
  end

  class IdentifySong
    def initialize(code)
      @code = code
    end

    def call
      if best_match.present?
        Song.find_by!(guid: best_match[:id])
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    private

      def best_match
        songs.first || {}
      end

      def songs
        @songs ||= client.identify(version: 4.12, code: @code)
      end

      def client
        Nestling.new.song
      end
  end
end
