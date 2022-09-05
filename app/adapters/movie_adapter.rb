class MovieAdapter
  include HTTParty

  base_uri(ENV.fetch("TMBD_API_URL", nil))

  def initialize
    @api_key = ENV.fetch("TMDB_API_KEY", nil)
  end

  def search(keyword, page = 1)
    Rails.logger.info("Search on TMDB service keyword: #{keyword}, page: #{page}")
    SearchRelation.new(response)
  end

  private

  def response
    # self.class.get("/search/movie", query: { api_key: @api_key, query: keyword, page: page }).parsed_response

    mock_response
  end

  # rubocop:disable Metrics/MethodLength, Lint/SymbolConversion
  def mock_response
    {
      "page": 1,
      "results": [
        {
          "adult": false,
          "backdrop_path": "/tonrulTmO9ZyZmsAsr5yr9ciE4c.jpg",
          "genre_ids": [16, 10_751],
          "id": 15_016,
          "original_language": "en",
          "original_title": "Barbie of Swan Lake",
          "overview": "Barbie as Odette, the young daughter of a baker, follows a unicorn into the Enchanted Forest " \
                      "and is transformed into a swan by an evil wizard intent on defeating the Fairy Queen.",
          "popularity": 58.436,
          "poster_path": "/sLpCLVQWTU7BI4yAL6kIFM9J3eX.jpg",
          "release_date": "2003-09-27",
          "title": "Barbie of Swan Lake",
          "video": false,
          "vote_average": 7,
          "vote_count": 939
        }
      ],
      "total_pages": 10,
      "total_results": 1000
    }
  end
  # rubocop:enable Metrics/MethodLength, Lint/SymbolConversion
end
