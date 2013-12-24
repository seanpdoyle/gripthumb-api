require 'spec_helper'

describe SongsController, "GET" do
  context "with an existing song code" do
    it "responds with the matching part" do
      part = create :part_with_song
      IdentifySongs.any_instance.stub(:call).and_return([part.song])

      post :identify, code: part.song_guid

      expect(response.body).to be_serialized part.song
    end
  end

  context "with a non-existent song code" do
    let(:match) { build(:song) }
    let(:lookup_job) { [match.guid, match.name, match.artist_name] }

    before do
      IdentifySongs.any_instance.stub(:call).and_return([match])
      post :identify, code: match.guid
    end

    it "enqueues a scrape job" do
      expect(ScrapeWorker).to have_enqueued_job(*lookup_job)
    end

    it "returns a 404" do
      expect(response.status).to eq 404
    end

    it "returns the song information" do
      expect(json).to eq({
        error: t("missing", collection: "songs"),
        song: {
          artist_name: match.artist_name,
          name: match.name
        }
      })
    end
  end
end