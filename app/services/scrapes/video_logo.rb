require 'open-uri'

class Scrapes::VideoLogo
  def call(video, logo_url)
    extension = logo_url.split('.').last

    file = Tempfile.new(['', ".#{extension}"])
    file.binmode # note that our tempfile must be in binary mode
    file.write open(logo_url).read
    file.rewind

    video.update! logo: file
  end
end
