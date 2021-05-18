defmodule MyTube.Query.Search do


  alias MyTube.Repo
  alias MyTube.Schema.Upload


  import Ecto.Query, warn: false


  @doc """
  List all uploads based on query.
  """

  def search(q, category) do
    if q && category do
      str = String.downcase(q)
      query =
        from u in Upload,
          where: u.category == ^category

      results =
        Repo.all(query)
        |> Enum.filter(fn item -> String.downcase(item.title) =~ str end)

      results
    else if q do
      str = String.downcase(q)
      query =
        from u in Upload,
	  select: u
	  
      Repo.all(query)
      |> Enum.filter(fn item -> String.downcase(item.title) =~ str end)
    else if category do
      query =
        from u in Upload,
	  where: u.category == ^category

      Repo.all(query)
    else
      Repo.all(Upload)
     
    end
    end
    end
  end
    
end