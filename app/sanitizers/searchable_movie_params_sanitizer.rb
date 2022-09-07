class SearchableMovieParamsSanitizer
  def initialize(params)
    @params = params.deep_dup
  end

  attr_reader :params

  def sanitized_params
    {
      page: params[:page] || 1,
      keyword: params[:keyword]
    }
  end
end
