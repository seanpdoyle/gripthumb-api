require 'spec_helper'

describe SongsController, "GET", fdoc: "songs/identify" do
  context "with an existing song code" do
    it "responds with the matching part" do
      part = create :part_with_song
      IdentifySongs.any_instance.stub(:call).and_return([part.song])

      post :identify, code: part.song_guid

      expect(response.body).to be_serialized part.song
    end
  end

  context "with an missing song" do
    context "unidentified by EchoNest" do

      before do
        IdentifySongs.any_instance.stub(:call).and_return([])
        post :identify, code: "12345"
      end

      it { should respond_with(:missing) }

      it "returns the error" do
        expect(json).to eq({
          error: t("missing", collection: "songs")
        })
      end
    end

    context "identified by EchnoNest" do
      let(:match)       { build(:song) }
      let(:lookup_job)  { [match.guid, match.artist_name, match.name] }

      before do
        IdentifySongs.any_instance.stub(:call).and_return([match])
        post :identify, code: match.guid
      end

      it { should respond_with(:missing) }

      it "enqueues a scrape job" do
        expect(ScrapeWorker).to have_enqueued_job(*lookup_job)
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
end