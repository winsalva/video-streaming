defmodule MyTube.Schema.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comments" do
    belongs_to :upload, MyTube.Schema.Upload
    field :content, :string
    timestamps([type: :utc_datetime_usec])
  end


  @doc false
  def changeset(comment, params \\ %{}) do
    comment
    |> cast(params, [:content, :upload_id])
    |> validate_required([:content, :upload_id])
    |> assoc_constraint(:upload)
  end
end