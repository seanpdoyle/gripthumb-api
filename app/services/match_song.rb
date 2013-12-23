class MatchSong
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
      songs.map do |song|
        [song[:id], song[:artist_name], song[:title]]
      end
    end
end
