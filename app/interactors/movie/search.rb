module Movie
  class Search
    include Interactor

    delegate :keyword, :page, to: :context
    delegate :count, to: :request, prefix: true

    def call
      check_cache

      context.fail!(error: t("errors.messages.movie.search.keyword_required")) if keyword.blank?
      context.fail!(error: response.error_message) unless response.success?
      context.results = result
    end

    private

    def check_cache
      if Rails.cache.exist?(cache_key)
        request.update(count: request_count + 1)
        context.external = true
      else
        request.update(count: 0)
      end
    end

    def cache_key
      "#{keyword}-#{page}"
    end

    def request
      @request ||= SearchRequest.find_or_create_by(keyword: keyword, page: page)
    end

    def result
      response.results.present? ? SearchRelation.new(response.results) : nil
    end

    def response
      @response ||= Rails.cache.fetch(cache_key, expires_in: 2.minutes) do
        Movies::Adapter.new.search(keyword, page)
      end
    end
  end
end
