require "rails_helper"

describe Tmdb::Client do
  let(:service) { described_class.new }
  let(:keyword) { "Titanic" }
  let(:query) do
    {
      api_key: "api-key",
      query: keyword,
      page: 1
    }
  end

  before do
    allow(ENV).to receive(:fetch).with("TMDB_API_KEY", "").and_return("api-key")
  end

  describe "#search" do
    subject(:search) { service.search(keyword) }

    it "makes get request to uri endpoint" do
      expect(described_class).to receive(:get).with("/search/movie", query: query)

      search
    end
  end
end
