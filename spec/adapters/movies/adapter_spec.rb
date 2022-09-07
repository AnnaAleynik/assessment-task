require "rails_helper"

describe Movies::Adapter do
  let(:adapter) { described_class.new }

  let(:tmdb_client) { instance_double Tmdb::Client, search: search_double }
  let(:search_double) do
    instance_double HTTParty::Response, success?: success?, parsed_response: response_body
  end

  let(:query_params) { "keyword" }

  let(:expected_search_movie_results) do
    {
      success?: success?,
      error_message: expected_error_message,
      results: results
    }
  end
  let(:expected_error_message) { nil }

  before do
    allow(Tmdb::Client).to receive(:new).and_return(tmdb_client)
  end

  describe "#search" do
    subject(:search) { adapter.search("keyword", 1) }

    context "when request is successfull" do
      let(:response_body) do
        {
          page: 1,
          results: [
            {
              adult: false,
              backdrop_path: "/tonrulTmO9ZyZmsAsr5yr9ciE4c.jpg",
              genre_ids: [16, 10_751],
              id: 15_016,
              original_language: "en",
              original_title: "Barbie of Swan Lake",
              overview: "Barbie as Odette, the young daughter of a baker, follows a unicorn into " \
                        "the Enchanted forest and is transformed into a swan by an evil wizard intent " \
                        "on defeating the Fairy Queen.",
              popularity: 58.436,
              poster_path: "/sLpCLVQWTU7BI4yAL6kIFM9J3eX.jpg",
              release_date: "2003-09-27",
              title: "Barbie of Swan Lake",
              video: false,
              vote_average: 7,
              vote_count: 939
            }
          ],
          total_pages: 10,
          total_results: 1000
        }
      end
      let(:results) { response_body }
      let(:success?) { true }

      it "request to tmdb client" do
        expect(Tmdb::Client).to receive_message_chain(:new, :search).with("keyword", 1)

        search
      end

      it { is_expected.to have_attributes(expected_search_movie_results) }
    end

    context "when request is failure with 401 response" do
      let(:response_body) do
        {
          "status_code" => 7,
          "status_message" => "Invalid API key: You must be granted a valid key.",
          "success" => false
        }
      end
      let(:success?) { false }
      let(:expected_error_message) { "Invalid API key: You must be granted a valid key." }
      let(:results) { nil }

      it { is_expected.to have_attributes(expected_search_movie_results) }
    end

    context "when request is failure with 422 response" do
      let(:response_body) { { "errors" => ["query must be provided"] } }
      let(:success?) { false }
      let(:expected_error_message) { "query must be provided" }
      let(:results) { nil }

      it { is_expected.to have_attributes(expected_search_movie_results) }
    end
  end
end
