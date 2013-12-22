class ApplicationController < ActionController::Base
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {error: "Failed to find #{controller_name}"}, status: 404
  end
end
