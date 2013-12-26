require 'nokogiri'

class Scrapes::SkateParts
  SEARCH = "http://www.skatevideosite.com/songsearch"

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
      elsif /and/i.match(@song.name)
        @song.name = @song.name.gsub(/and/i, "&")
        self.class.new(@song).call
      end
    end
  end

  private
    def scrape
      skate_videos.each do |skate_video|
        Scrapes::SkateVideo.new(skate_video, @song).call
      end
    end

    def skate_videos
      document.css(".skatevideo")
    end

    def document
      @document ||= Nokogiri::HTML(response)
    end

    def search_term
      "#{@song.artist_name} #{@song.name}"
    end

    def search_uri
      URI.parse([SEARCH, Rack::Utils.escape(search_term)].join('/'))
    end

    def response
      Net::HTTP.get(search_uri)
    end
end
