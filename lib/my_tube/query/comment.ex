defmodule MyTube.Query.Comment do
  @moduledoc """
  Documentation for Comment Query
  """

  alias MyTube.{Repo}
  alias MyTube.Schema.Comment
  alias MyTube.Query.Upload
  import Ecto.Query, warn: false


  @doc """
  New comment.
  """
  def new_comment do
    %Comment{}
    |> Comment.changeset()
  end
  

  def insert_comment(upload_id, params) do
    Upload.get_upload!(upload_id)
    |> Ecto.build_assoc(:comments)
    |> Comment.changeset(params)
    |> Ecto.Changeset.cast_assoc(:upload, with: &MyTube.Schema.Upload.changeset/2)
    |> Repo.insert()
  end
end