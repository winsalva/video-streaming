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
  def changeset(user, attr \\ %{}) do
    user
    |> cast(attr, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> validate_length(:name, min: 3, max: 50)
    |> validate_format(:email, ~r/@/, message: "has invalid format")
    |> validate_length(:email, max: 50)
    |> unique_constraint(:email)
  end


  def changeset_with_password(%User{} = user, attr \\ %{}) do
    user
    |> cast(attr, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 20)
    |> validate_confirmation(:password, required: true)
    |> hash_password()
    |> changeset(attr)
  end


  defp hash_password(%Ecto.Changeset{changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:hashed_password, MyTube.Password.hash(password))
  end

  defp hash_password(changeset), do: changeset
    
end
