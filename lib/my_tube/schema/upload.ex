defmodule MyTube.Schema.Upload do
  @moduledoc """
  Documentation for Upload Schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias MyTube.Schema.Upload


  schema "uploads" do
    belongs_to :user, MyTube.Schema.User
    field :title, :string
    field :file, :string
    field :description, :string
    timestamps([type: :utc_datetime_usec])
  end


  @allowed_fields [
    :user_id,
    :title,
    :file,
    :description
  ]


  @doc false
  def changeset(%Upload{} = upload, attr \\ %{}) do
    upload
    |> cast(attr, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> assoc_constraint(:user)
  end
end