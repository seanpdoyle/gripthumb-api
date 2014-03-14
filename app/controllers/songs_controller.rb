class SongsController < InheritedResources::Base
  custom_actions collection: :identify

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: missing_song_response, status: 404
  end

  def identify
    render json: Song.identify(song_code, identifier)
  end

  private
    def identifier
      @identifier ||= IdentifySongs.new(song_code)
    end

    def missing_song_response
      missing_response = {
        error: t("missing", collection: "songs")
      }
      if best_match = identifier.call.first
        missing_response.merge! song: {
          name: best_match.name,
          artist_name: best_match.artist_name
        }
      end
      missing_response
    end

    def song_code
      params[:code]
    end
end
