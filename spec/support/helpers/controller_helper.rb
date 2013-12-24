module ControllerHelper
  def json
    JSON.parse(response.body).deep_symbolize_keys
  end
end
