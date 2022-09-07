require "rails_helper"

describe Movie::Search do
  describe "#call" do
    include_context "with interactor"

    let(:initial_context) do
      {
        keyword: keyword,
        page: page
      }
    end
    let(:keyword) { "keyword" }
    let(:page) { 4 }

    let(:tmdb_client) { instance_double Tmdb::Client, search: search_double }
    let(:search_double) do
      instance_double HTTParty::Response, success?: success?, parsed_response: results
    end

    let(:success?) { true }
    let(:results) do
      {
        page: 4,
        results: [
          { payload: "payload" },
          { payload: "payload" }
        ],
        total_pages: 10,
        total_results: 1000
      }
    end
    let(:search_request) { SearchRequest.find_by(keyword: "keyword", page: 4) }

    before do
      allow(Tmdb::Client).to receive(:new).and_return(tmdb_client)
    end

    it "returns the data" do
      interactor.run

      expect(search_request.count).to eq(0)
      expect(context).to be_success
      expect(context.results).to be_a_search_relation(results)
    end

    context "when response failed" do
      let(:success?) { false }
      let(:results) do
        {
          "status_code" => 7,
          "status_message" => "Invalid API key: You must be granted a valid key.",
          "success" => false
        }
      end

      it "returns error" do
        interactor.run

        expect(context).to be_failure
        expect(context.error).to eq("Invalid API key: You must be granted a valid key.")
      end
    end
  end
end
