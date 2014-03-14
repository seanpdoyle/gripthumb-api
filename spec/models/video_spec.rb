require 'spec_helper'

describe Video do
  it { should have_many(:parts) }
  it { should have_many(:songs).through(:parts) }

  it { should have_attached_file(:logo) }
  it { should validate_attachment_content_type(:logo).allowing("image/jpeg", "image/gif", "image/png") }
end
