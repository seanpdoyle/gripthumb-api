class ScrapeWorker
  include Sidekiq::Worker

  def perform(guid, artist_name, song_name)
    Scrapes::SkateParts.new(
      Song.new(guid: guid, name: song_name, artist_name: artist_name)
    ).call
  end
end