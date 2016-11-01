defmodule HelloPhoenix.Repo.Migrations.AddTeamCaptain do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :captain_id, references(:users)
    end
  end
end
