module Tmdb
  class Client
    include HTTParty

    base_uri(ENV.fetch("TMBD_API_URL", nil))

    def initialize
      @api_key = ENV.fetch("TMDB_API_KEY", "")
    end

    def search(keyword, page = 1)
      Rails.logger.info("Search on TMDB service keyword: #{keyword}, page: #{page}")

      self.class.get("/search/movie", query: { api_key: @api_key, query: keyword, page: page })
    end
  end
end
