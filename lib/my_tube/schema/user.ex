defmodule MyTube.Schema.User do
  @moduledoc """
  Documentation for User Schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias MyTube.Schema.User
  

  schema "users" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true
    timestamps([type: :utc_datetime_usec])
  end


  @allowed_fields [
    :name,
    :email,
    :hashed_password
  ]


  @doc false
  def changeset(%User{} = user, attr \\ %{}) do
    user
    |> cast(attr, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> unique_constraint(:email)
  end

end
