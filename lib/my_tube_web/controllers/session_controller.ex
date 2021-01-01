defmodule MyTubeWeb.SessionController do
  use MyTubeWeb, :controller



  alias MyTube.Query.User


  def login(conn, _params) do
    render(conn, :new)
  end


  def create(conn, %{"email" => email, "password" => password}) do
    case User.get_user_by_email_and_password(email, password) do
      %MyTube.Schema.User{} = user ->
        conn
	|> put_session(:user_id, user.id)
	|> put_flash(:info, "You are now logged in")
	|> redirect(to: "/")
      false ->
        conn
	|> put_flash(:error, "Email and Password not found!")
	|> render(:new)
    end
  end
end