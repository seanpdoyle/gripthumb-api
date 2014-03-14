require 'spec_helper'

describe Part do
  it { should belong_to(:video).touch(true) }
  it { should belong_to(:song).touch(true) }
    delegate :guid, to: :song, prefix: true, allow_nil: true
end

describe Part, "#song_guid" do
  it "delegates to the song" do
    song = Song.new(guid: "the-guid")
    part = Part.new(song: song)

    expect(part.song_guid).to eq("the-guid")
  end
end
