module Movies
  class Adapter
    SearchResult = Struct.new(:success?, :error_message, :results)

    def search(keyword, page = 1)
      response = client.search(keyword, page)

      SearchResult.new(
        response.success?,
        error_message(response),
        results(response)
      )
    end

    private

    def client
      @client ||= Tmdb::Client.new
    end

    def error_message(response)
      return nil if response.success?

      response.parsed_response["status_message"] || response.parsed_response["errors"].join(", ")
    end

    def results(response)
      return nil unless response.success?

      response.parsed_response.deep_symbolize_keys
    end
  end
end
