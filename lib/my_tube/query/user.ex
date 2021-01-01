defmodule MyTube.Query.User do
  @moduledoc """
  Documentation for User Query.
  """

  alias MyTube.Schema.User
  alias MyTube.Repo


  @doc """
  New user.
  """
  def new_user do
    User.changeset_with_password(%User{})
  end
  

  @doc """
  Get user by id.
  """
  def get_user!(id) do
    Repo.get(User, id)
  end


  @doc """
  Edit user.
  """
  def edit_user(id) do
    get_user!(id)
    |> User.changeset()
  end


  @doc """
  Update user
  """
  def update_user(id, params) do
    get_user!(id)
    |> User.changeset(params)
    |> Repo.update()
  end


  @doc """
  Get user by attribute.
  """
  def get_user_by(attr) do
    Repo.get_by(User, attr)
  end


  @doc """
  Get user by email and password
  """
  def get_user_by_email_and_password(email, password) do
    with user when not is_nil(user) <- get_user_by(%{email: email}),
      true <- MyTube.Password.verify_with_hash(password, user.hashed_password) do
      user
    else
      _ -> MyTube.Password.dummy_verify
    end
  end


  @doc """
  Insert new user.
  """
  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> Repo.insert()
  end
end