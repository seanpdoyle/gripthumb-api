require 'fdoc'
require 'fdoc/spec_watcher'

Fdoc.service_path = "docs/fdocs"

# Configure how Fdoc decides a successful response
Fdoc.decide_success_with do |response, status|
 status.to_i < 400
end

RSpec.configure do |config|
  config.include Fdoc::SpecWatcher, type: :controller
end