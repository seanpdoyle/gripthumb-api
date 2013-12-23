require 'spec_helper'

describe ScrapesSkateParts, "given an Echoprint response" do
  let(:guid)    { "SODUMAG137283652FD" }
  let(:artist)  { "JAY Z" }
  let(:name)    { "On to the Next One (feat. Swizz Beats)" }

  before do
    ScrapesSkateParts.new(
      build(
        :song,
        artist_name: artist,
        name: name,
        guid: guid
      )
    ).call
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
  Song.find_by!(name: "On to the Next One")
end

def sabotage_3
  Video.find_by!(name: "Sabotage3")
end

def mark_suciu_part
  Part.last
end
