require 'spec_helper'

describe SongsController, "GET" do
  context "with an existing song code" do
    it "responds with the matching part" do
      part = create :part_with_song
      IdentifiesSong.stub(:with_code).with(part.song_guid).and_return(part.song)

      post :identify, code: part.song_guid

      expect(response.body).to be_serialized part.song
    end
  end
end