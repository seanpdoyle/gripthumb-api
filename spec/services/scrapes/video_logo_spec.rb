require 'spec_helper'

describe Scrapes::VideoLogo, "#call" do
  let(:video)    { create :video }
  let(:logo_url) { "http://skatevideosite.com/images/phpThumb.php?src=covers/sabotage3.jpg&w=90" }

  subject(:logo) { video.logo }

  before do
    Scrapes::VideoLogo.new.call(video, logo_url)
  end

  it "has as square version" do
    expect(logo.url(:square)).not_to be_missing_logo_for(:square)
  end
end

def be_missing_logo_for(type)
  eq "/videos/#{type}/missing.jpg"
end