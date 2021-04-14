defmodule MyTubeWeb.PageController do
  use MyTubeWeb, :controller


  alias MyTube.Query.Upload


  def index(conn, _params) do
    uploads = Upload.list_uploads()
    render(conn, "index.html", uploads: uploads)
  end



  def test(conn, _) do
    conn
    |> put_layout("light.html")
    |> render(:test)
  end
end
