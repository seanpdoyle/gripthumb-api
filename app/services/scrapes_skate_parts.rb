require 'nokogiri'

class ScrapesSkateParts
  URI = URI.parse("http://www.skatevideosite.com/songsearch")

  def initialize(song)
    @song = song
  end

  def call
    if skate_videos.present?
      scrape
    else
      if @song.parentheses_in_name?
        @song.name = @song.sanitized_name
        self.class.new(@song).call
      end
    end
  end

  private
    def scrape
      skate_videos.each do |skate_video|
        ScrapesSkateVideo.new(skate_video, @song).call
      end
    end

    def skate_videos
      document.css(".skatevideo")
    end

    def document
      @document ||= Nokogiri::HTML(response.body)
    end

    def response
      Net::HTTP.post_form URI, {
        searchterm: "#{@artist_name} #{@song.name}"
      }
    end
end
