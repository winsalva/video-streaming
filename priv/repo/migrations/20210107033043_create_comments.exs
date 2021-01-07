defmodule MyTube.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :upload_id, references(:uploads, on_delete: :delete_all), null: false
      add :content, :text
      timestamps([type: :utc_datetime_usec])
    end
  end
end
