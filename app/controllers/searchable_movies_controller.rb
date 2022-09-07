class SearchableMoviesController < ApplicationController
  def index
    response = Movie::Search.call(search_params)

    @external = response.external
    if response.success?
      @results = response.results
    else
      @error = response.error
    end
  end

  private

  def search_params
    SearchableMovieParamsSanitizer.new(searchable_params).sanitized_params
  end

  def searchable_params
    params.permit(:page, :keyword).to_h
  end
end
