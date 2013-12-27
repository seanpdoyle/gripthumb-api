class Scrapes::SkateVideo
  PART    = /(.+)-.+-.+/
  ARTIST  = /.+-(.+)-.+/
  SONG    = /.+-.+-(.+)/

  attr_reader :song

  def initialize(node, song)
    @node       = node
    @song       = song
  end

  def call
    if matches?
      song.save!
      video.save!
      part.update!(song: song, video: video)

      if logo_src.present?
        VideoLogoWorker.perform_async(video.id, logo_url)
      end
    end
  end

  private
    def matches?
      /#{song.name}/i.match(song_name) &&
      /#{song.artist_name}/i.match(artist_name)
    end

    def logo_src
      (@node.css("a img").first || {})["src"]
    end

    def logo_url
      ["http://skatevideosite.com", logo_src.gsub("w=90", "w=200")].join
    end

    def video
      @video ||= Video.find_or_create_by(name: video_name)
    end

    def video_name
      (@node.css("a.videotitle").first.content || "").squish
    end

    def part
      video.parts.find_or_create_by(name: part_name)
    end

    def part_name
      matching(PART)
    end

    def artist_name
      matching(ARTIST)
    end

    def song_name
      matching(SONG)
    end

    def matching(regex)
      (regex.match(info_node) || [nil, ""])[1].squish
    end

    def info_node
      @info_node ||= @node.css("p.small").first.content.squish
    end
end
