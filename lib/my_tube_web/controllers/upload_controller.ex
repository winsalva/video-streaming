defmodule MyTubeWeb.UploadController do
  use MyTubeWeb, :controller



  alias MyTube.Query.{Upload, Comment}


  def new(conn, _params) do
    changeset = Upload.new_upload()
    render(conn, :new, changeset: changeset)
  end


  def create(conn, %{"upload" => %{"title" => title, "file" => file, "description" => description} = _params}) do
    user_id = conn.assigns.current_user.id
    
    params = %{
      user_id: user_id,
      title: title,
      file: file.filename,
      description: description
    }
    case Upload.insert_upload(file, user_id, params) do
      {:ok, upload} ->
        conn
	|> put_flash(:info, "Upload successfully")
	|> redirect(to: "/")
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
	|> render(:new, changeset: changeset)
    end
  end


  def create(conn, %{"upload" => %{"title" => title, "description" => description} = params}) do
    case Upload.insert_upload(params) do
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
	|> render(:new, changeset: changeset)
      _ ->
        conn
	|> put_flash(:error, "There was an error uploading your video.")
	|> redirect(to: "/")
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
end