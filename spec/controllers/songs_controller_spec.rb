require 'spec_helper'

describe SongsController, "GET" do
  context "with an existing song code" do
    it "responds with the matching part" do
      part = create :part_with_song
      MatchSong.stub(:with_code).with(part.song_guid).and_return(part.song)

      post :identify, code: part.song_guid

      expect(response.body).to be_serialized part.song
    end
  end

  context "with a non-existent song code" do
    let(:match) do
      {id: "1234", artist_name: "artist", title: "name"}
    end

    before do
      IdentifySongs.any_instance.stub(:call).and_return([match])
      post :identify, code: match[:id]
    end

    it "enqueues a scrape job" do
      expect(ScrapeWorker).to have_enqueued_job(match[:id], match[:artist_name], match[:title])
    end

    it "returns a 404" do
      expect(response.status).to eq 404
    end
  end
end