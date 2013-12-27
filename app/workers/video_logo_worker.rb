class VideoLogoWorker
  include Sidekiq::Worker

  ERRORS = [Encoding::UndefinedConversionError, ActiveRecord::RecordNotFound].freeze

  def perform(video_id, logo_url)
    Scrapes::VideoLogo.new.call(Video.find(video_id), logo_url)
  rescue *ERRORS
  end
end
