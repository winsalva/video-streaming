defmodule MyTubeWeb.UserController do
  use MyTubeWeb, :controller


  alias MyTube.Query.User


  @doc """
  Render new registration page.
  """
  def new(conn, _params) do
    changeset = User.new_user()
    render(conn, :new, changeset: changeset)
  end


  @doc """
  Create user.
  """
  def create(conn, %{"user" => %{"name" => name, "email" => email, "password" => password, "password_confirmation" => password_confirmation} = params}) do
  case User.insert_user(params) do
    {:ok, _user} ->
      conn
      |> put_flash(:info, "Congrats for registering your account!")
      |> redirect(to: Routes.page_path(conn, :index))
    {:error, %Ecto.Changeset{} = changeset} ->
      conn
      |> render(:new, changeset: changeset)
    end
  end
end