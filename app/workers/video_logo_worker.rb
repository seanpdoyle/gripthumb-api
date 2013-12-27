class VideoLogoWorker
  include Sidekiq::Worker

  def perform(video_id, logo_url)
    video = Video.find(video_id)
    video.update!(logo: Downloads.new.call(logo_url.to_s))
  rescue ActiveRecord::RecordNotFound
  end
end
