class SearchRelation
  def initialize(data)
    @data = data
    @results = data[:results]
    @total_results = data[:total_results]
    @limit = 20
  end

  attr_reader :data, :results, :limit

  def current_page
    data[:page]
  end

  def total_pages
    data[:total_pages]
  end

  def all
    results
  end

  def limit_value
    limit
  end
end
