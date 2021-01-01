defmodule MyTubeWeb.PageController do
  use MyTubeWeb, :controller


  alias MyTube.Query.Upload


  def index(conn, _params) do
    uploads = Upload.list_uploads()
    render(conn, "index.html", uploads: uploads)
  end
end
