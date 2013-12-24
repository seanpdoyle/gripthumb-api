class MatchSong
  KEYS = [:id, :artist_name, :title].freeze

  def self.with_code(code, identify = nil)
    new(code, identify).call
  end

  def initialize(code, identify = nil)
    @code = code
    @identify = identify || IdentifySongs.new(@code)
  end

  def call
    best_match || enqueue_lookup
  end

  private
    def enqueue_lookup
      song_jobs.each{|job| ScrapeWorker.perform_async(*job) }
      raise(ActiveRecord::RecordNotFound)
    end

    def best_match
      songs.inject(nil) do |match, song|
        match || Song.find_by(guid: song[:id])
      end
    end

    def songs
      @songs ||= @identify.call
    end

    def song_jobs
      songs.map{|song|
        if KEYS.all?{|k| song.has_key?(k)}
          KEYS.map{|k| song[k]}
        end
      }.reject(&:blank?)
    end
end
