require 'spec_helper'

describe Downloads, "#call" do
  let(:logo_url)  { Rails.root.join("spec/support/files/logo.jpg") }
  let(:file)      { Downloads.new.call(logo_url) }

  it "downloads the file from the URL into a Tempfile" do
    expect(file.length).to be > 0
  end
end
