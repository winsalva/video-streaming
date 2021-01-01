defmodule MyTube.Query.Upload do
  @moduledoc """
  Documentation for Upload Query.
  """


  alias MyTube.Repo
  alias MyTube.Schema.Upload
  import Ecto.Query
  

  @doc """
  List all uploads.
  """
  def list_uploads do
    query =
      from u in Upload,
        order_by: [desc: :updated_at]

    Repo.all(query)
  end
end