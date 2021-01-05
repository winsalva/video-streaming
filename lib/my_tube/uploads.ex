defmodule MyTube.Uploads do
  @moduledoc """
  Documetation for MyTube Uploads.
  """

  def upload_dir do
    Application.get_env(:my_tube, :uploads_dir)
  end


  @doc """
  Uploads local directory.
  """
  def local_path(user_id, filename) do
    [upload_dir(), "#{user_id}-#{filename}"]
    |> Path.join()
  end
end