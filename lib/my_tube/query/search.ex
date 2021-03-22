defmodule MyTube.Query.Search do


  alias MyTube.Repo
  alias MyTube.Schema.Upload


  import Ecto.Query, warn: false


  @doc """
  List all uploads based on query.
  """
  def search(q) do
    query =
      from u in Upload,
        where: ilike(u.title, ^"#{q}%"),
        select: u

    Repo.all(query)
  end
end