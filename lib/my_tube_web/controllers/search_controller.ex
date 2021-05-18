defmodule MyTubeWeb.SearchController do
  use MyTubeWeb, :controller


  alias MyTube.Query.Search


  def search(conn, %{"query" => query_string, "category" => category}) do
    query =
      case Search.search(query_string, category) do
        [] -> []
        results -> results
      end

    render(conn, :index, query: query, query_string: query_string)
  end


  def index(conn, _) do
    render(conn, :index, query: nil)
  end
end