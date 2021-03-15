defmodule MyTube.Query.Upload do
  @moduledoc """
  Documentation for Upload Query.
  """


  alias MyTube.{Repo}
  alias MyTube.Schema.Upload
  import Ecto.Query
  

  @doc """
  List all uploads.
  """
  def list_uploads do
    query =
      from u in Upload,
        order_by: [desc: :updated_at],
	preload: [:user, :comments]

    Repo.all(query)
  end


  @doc """
  New upload.
  """
  def new_upload do
    %Upload{}
    |> Upload.changeset()
  end


  @doc """
  Insert new upload.
  """
  def insert_upload(params) do
    %Upload{}
    |> Upload.changeset(params)
    |> Repo.insert()
  end


  @doc """
  Get upload by id.
  """
  def get_upload!(id) do
    query =
      from u in Upload,
        where: u.id == ^id,
	preload: [:user, :comments]

    Repo.one(query)
  end
end