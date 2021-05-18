defmodule MyTube.Repo.Migrations.AlterUploads do
  use Ecto.Migration

  def change do
    alter table(:uploads) do
      add :category, :string
    end
  end
end
