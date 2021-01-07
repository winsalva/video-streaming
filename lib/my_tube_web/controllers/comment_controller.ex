defmodule MyTubeWeb.CommentController do
  use MyTubeWeb, :controller

  alias MyTube.Query.Comment


  def create(conn, %{"comment" => %{"content" => content} = params, "upload_id" => upload_id}) do
    case Comment.insert_comment(upload_id, params) do
      {:ok, comment} ->
        conn
	|> redirect(to: Routes.upload_path(conn, :show, upload_id))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
	|> put_flash(:error, "Something went wrong.")
	|> redirect(to: Routes.upload_path(conn, :show, upload_id))
    end
  end
end