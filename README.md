You can find deployed app ["Here"](https://assessment-search-movie.herokuapp.com/)


This project created for searching movies on ["The Movie Database"](https://developers.themoviedb.org/3/search/search-movies)

- The backend is implemented in ruby and ruby on rails
- PostgreSQL

# High level workflow:

## Sending Requests:
The UI (from the browser) sends request to the backend.

## Processing the request:
The query consist the search term and optionally the current page.

The backend checks if the same query has received within 2 mins and the results are already saved in its data store?

  1. If not, it forwards the request to 3rd party API:
    - Fetch movies matching the query: The API is ["The Movie Database - registration required"](https://developers.themoviedb.org/3/search/search-movies).
      - Call interactor Movie::Search
      - Interactor calls Movies::Adapter. It processes result from Services::Tmdb::Client, that create request to API.
    - Save the search and its results in a cache:
      - Results returned by The Movie Database API
      - Set view count to 0

  2. If yes:
    If the same keyword(s) are looked up within 2 mins:
    - Serve directly by the backend, no API request sent to the 3rd party API.
    - Record view count increment by 1

## Pagination
The results is paginated if more than 20 items returned by the query.

# Future improvements
- Services::Tmdb::Client can be used to sending other request to ["The Movie Database"](https://developers.themoviedb.org/3)
- Create show page for Movie
- Use Redis as cache store
