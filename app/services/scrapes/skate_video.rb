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
    end
  end

  private
    def matches?
      /#{song.name}/i.match(song_name) &&
      /#{song.artist_name}/i.match(artist_name)
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
      PART.match(info_node)[1].squish
    end

    def artist_name
      ARTIST.match(info_node)[1].squish
    end

    def song_name
      SONG.match(info_node)[1].squish
    end

    def info_node
      @info_node ||= @node.css("p.small").first.content.squish
    end
end
