defmodule MyTube.Repo.Migrations.CreateUploads do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :title, :string
      add :file, :string
      add :description, :text
      timestamps([type: :utc_datetime_usec])
    end
  end
end
