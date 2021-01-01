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


  @doc """
  Show user.
  """
  def show(conn, %{"id" => id}) do
    user = User.get_user!(id)
    render(conn, :show, user: user)
  end


  @doc """
  Edit user
  """
  def edit(conn, %{"id" => id}) do
    user = User.edit_user(id)
    render(conn, :edit, user: user)
  end


  @doc """
  Update user.
  """
  def update(conn, %{"user" => params, "id" => id}) do
    case User.update_user(id, params) do
      {:ok, user} ->
        conn
	|> put_flash(:info, "Updated successfully.")
	|> redirect(to: Routes.user_path(conn, :show, user.id))
      {:error, %Ecto.Changeset{} = user} ->
        conn
	|> render(:edit, user: user)
    end
  end
end