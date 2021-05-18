defmodule MyTube.Schema.Upload do
  @moduledoc """
  Documentation for Upload Schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias MyTube.Schema.Upload


  schema "uploads" do
    belongs_to :user, MyTube.Schema.User
    has_many :comments, MyTube.Schema.Comment
    field :category, :string
    field :title, :string
    field :file, :string
    field :description, :string
    timestamps([type: :utc_datetime_usec])
  end


  @allowed_fields [
    :user_id,
    :category,
    :title,
    :file,
    :description
  ]


  @doc false
  def changeset(%Upload{} = upload, attr \\ %{}) do
    upload
    |> cast(attr, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> validate_length(:title, max: 100)
    |> validate_length(:file, max: 100)
    |> validate_length(:description, max: 1500)
    |> assoc_constraint(:user)
  end
end