defmodule HelloPhoenix.Repo.Migrations.AddNamePrefToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :captain_preference, :boolean
      add :name,  :text
    end
  end
end
