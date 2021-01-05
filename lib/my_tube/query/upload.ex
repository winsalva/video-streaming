defmodule MyTube.Query.Upload do
  @moduledoc """
  Documentation for Upload Query.
  """


  alias MyTube.{Repo, Uploads}
  alias MyTube.Schema.Upload
  import Ecto.Query
  

  @doc """
  List all uploads.
  """
  def list_uploads do
    query =
      from u in Upload,
        order_by: [desc: :updated_at],
	preload: [:user]

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
  Insert upload and upload file to local path.
  """
  def insert_upload(video, user_id, params) do
    Repo.transaction(fn ->
      with {:ok, upload} <- insert_upload(params),
        :ok <- File.cp(video.path, Uploads.local_path(user_id, video.filename)) do
	  {:ok, upload}
      else
	  {:error, reason} -> Repo.rollback(reason)
      end
    end)
  end


  @doc """
  Get upload by id.
  """
  def get_upload!(id) do
    Repo.get!(Upload, id)
  end
end