require "spec_helper"

describe Unsplash::CuratedBatch do

  let (:batch_id) { 2 }
  let (:fake_id)  { 1234 }

  before :all do
    Unsplash::CuratedBatch.connection = @test_connection
  end

  describe "#find" do
    it "returns a CuratedBatch object" do
      VCR.use_cassette("curated_batches", record: :new_episodes) do
        @batch = Unsplash::CuratedBatch.find(batch_id)
      end

      expect(@batch).to be_a Unsplash::CuratedBatch
    end

    it "errors if the batch doesn't exist" do
      expect {
        VCR.use_cassette("curated_batches", record: :new_episodes) do
          @batch = Unsplash::CuratedBatch.find(fake_id)
        end
      }.to raise_error Unsplash::Error
    end
  end

  describe "#all" do
    it "returns an array of Categories" do
      VCR.use_cassette("curated_batches", record: :new_episodes) do
        @batches = Unsplash::CuratedBatch.all(1, 12)
      end

      expect(@batches).to be_an Array
      expect(@batches.size).to eq 12
    end
  end

  describe "#photos" do
    it "returns an array of Photos" do
      VCR.use_cassette("curated_batches", record: :new_episodes) do
        @photos = Unsplash::CuratedBatch.find(batch_id).photos
      end

      expect(@photos).to be_an Array
      expect(@photos.size).to eq 10
    end
  end
end