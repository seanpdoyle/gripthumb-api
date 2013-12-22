class IdentifiesSong
  def self.with_code(code)
    IdentifySong.new(code).call
  end

  class IdentifySong
    def initialize(code)
      @code = code
    end

    def call
      best_match || raise(ActiveRecord::RecordNotFound)
    end

    private
      def best_match
        songs.inject(nil) do |match, song|
          match || Song.find_by(guid: song[:id])
        end
      end

      def songs
        @songs ||= client.identify(version: 4.12, code: @code)
      end

      def client
        Nestling.new.song
      end
  end
end
