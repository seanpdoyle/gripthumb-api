require 'spec_helper'

describe Scrapes::SkateParts, "given an Echoprint response" do
  let(:guid)    { "SODUMAG137283652FD" }
  let(:artist)  { "JAY Z" }
  let(:name)    { "On to the Next One (feat. Swizz Beats)" }
  let(:logo_url){ "http://skatevideosite.com/images/phpThumb.php?src=covers/sabotage3.jpg&w=90" }

  before do
    Scrapes::SkateParts.new(
      build(
        :song,
        artist_name: artist,
        name: name,
        guid: guid
      )
    ).call
  end

  it "enqueues a job to download the Video's logo" do
    expect(VideoLogoWorker).to have_enqueued_job(sabotage_3.id, logo_url)
  end

  context "the created song" do
    subject(:created_song) { on_to_the_next_one }

    its(:guid)        { should eq guid    }
    its(:name)        { should fuzzy_match "On to the Next One" }
    its(:artist_name) { should fuzzy_match "Jay Z"  }
  end

  context "the created part" do
    subject(:created_part) { mark_suciu_part }

    its(:name) { should fuzzy_match "Mark Suciu #2" }
    its(:video){ should eq sabotage_3 }
    its(:song) { should eq on_to_the_next_one }
  end
end

def on_to_the_next_one
  @song ||= Song.find_by!(name: "On to the Next One")
end

def sabotage_3
  @video ||= Video.find_by!(name: "Sabotage3")
end

def mark_suciu_part
  @part ||= Part.last
end
