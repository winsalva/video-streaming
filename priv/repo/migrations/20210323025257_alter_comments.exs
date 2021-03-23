defmodule MyTube.Repo.Migrations.AlterComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
