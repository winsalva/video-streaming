defmodule MyTubeWeb.UploadController do
  use MyTubeWeb, :controller



  alias MyTube.Query.Upload


  def new(conn, _params) do
    changeset = Upload.new_upload()
    render(conn, :new, changeset: changeset)
  end


  def create(conn, %{"upload" => %{"title" => title, "file" => file, "description" => description} = param}) do
    params = %{
      user_id: conn.assigns.current_user.id,
      title: title,
      file: file.filename,
      description: description
    }
    case Upload.insert_upload(params) do
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
end