require 'open-uri'

class Scrapes::VideoLogo
  def call(video, logo_url)
    open(logo_url) do |stream|
      video.update! logo: stream
    end
  end
end
