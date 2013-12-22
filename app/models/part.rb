class Part < ActiveRecord::Base
  belongs_to :video, touch: true
  belongs_to :song, touch: true

  delegate :guid, to: :song, prefix: true, allow_nil: true
end
