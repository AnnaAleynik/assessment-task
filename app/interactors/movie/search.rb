module Movie
  class Search
    include Interactor

    delegate :keyword, :page, to: :context
    delegate :count, to: :request, prefix: true

    def call
      if Rails.cache.exist?(cache_key)
        request.update(count: request_count + 1)
        context.external = true
      else
        request.update(count: 0)
      end

      context.response = response
    end

    private

    def cache_key
      "#{keyword}-#{page}"
    end

    def request
      @request ||= SearchRequest.find_or_create_by(keyword: keyword, page: page)
    end

    def response
      Rails.cache.fetch(cache_key, expires_in: 2.minutes) do
        MovieAdapter.new.search(keyword, page)
      end
    end
  end
end
