class MatchSong
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
        match || Song.find_by(guid: song.guid)
      end
    end

    def songs
      @songs ||= @identify.call
    end

    def song_jobs
      songs.map{|song| [song.guid, song.name, song.artist_name]}
    end
end
