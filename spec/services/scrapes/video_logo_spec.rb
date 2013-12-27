require 'spec_helper'

describe Scrapes::VideoLogo, "#call" do
  let(:video)    { create :video }
  let(:logo_url) { "http://skatevideosite.com/images/phpThumb.php?src=covers/sabotage3.jpg&w=200" }

  subject(:logo) { video.logo }

  before do
    Scrapes::VideoLogo.new.call(video, logo_url)
  end

  it "has a thumbnail version" do
    expect(logo.url(:thumb)).to match logo_matcher(:thumb)
  end

  it "has as square version" do
    expect(logo.url(:square)).to match logo_matcher(:square)
  end
end

def logo_matcher(type)
  /system\/videos\/logos\/000\/000\/\d\/#{type}\/.*\.jpg/i
end