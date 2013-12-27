require 'spec_helper'

describe VideoLogoWorker, "#perform" do
  let(:url)   { Rails.root.join("spec/support/files/logo.jpg") }
  let(:video) { create :video }

  it "sets the video's logo to the downloaded file" do
    subject.perform(video.id, url)
    expect(video.reload.logo).not_to eq "/videos/square/missing.jpg"
  end
end