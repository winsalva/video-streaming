defmodule MyTubeWeb.UploadController do
  use MyTubeWeb, :controller


  plug :authenticate when action not in [:show]

  alias MyTube.Query.{Upload, Comment}


  def new(conn, _params) do
    changeset = Upload.new_upload()
    render(conn, :new, changeset: changeset)
  end



  def create(conn, %{"upload" => %{"title" => title, "file" => file, "description" => description} = params}) do
    params = Map.put(params, "user_id", conn.assigns.current_user.id)

    case Upload.insert_upload(params) do
      {:ok, _upload} ->
        conn
	|> redirect(to: "/")
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> render(:new, changeset: changeset)
    end
  end

  @doc """
  Show an upload 
  """
  def show(conn, %{"id" => id}) do
    upload = Upload.get_upload!(id)
    comment = Comment.new_comment()
    render(conn, :show, upload: upload, comment: comment)
  end



  ### authenticator.
  defp authenticate(conn, _params) do
    with user when not is_nil(user) <- conn.assigns.current_user do
      conn
    else
      nil ->
        conn |> redirect(to: "/") |> halt()
    end
  end
end