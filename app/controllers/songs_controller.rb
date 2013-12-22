class SongsController < InheritedResources::Base
  custom_actions collection: :identify

  def identify
    render json: Song.identify(params[:code])
  end
end