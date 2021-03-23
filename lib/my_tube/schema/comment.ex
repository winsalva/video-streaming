defmodule MyTube.Schema.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  alias MyTube.Schema.{Upload, User}
  

  schema "comments" do
    belongs_to :upload, Upload
    belongs_to :user, User
    field :content, :string
    timestamps([type: :utc_datetime_usec])
  end

  @allowed_fields [
    :user_id,
    :upload_id,
    :content
  ]

  @doc false
  def changeset(comment, params \\ %{}) do
    comment
    |> cast(params, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> assoc_constraint(:upload)
  end
end