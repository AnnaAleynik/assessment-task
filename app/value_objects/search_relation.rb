class SearchRelation
  def initialize(results)
    @results = results
    @page = results[:page]
    @limit = 20
  end

  attr_reader :results, :limit

  def current_page
    results[:page]
  end

  def total_pages
    results[:total_pages]
  end

  def all
    results[:results]
  end

  def limit_value
    limit
  end
end
