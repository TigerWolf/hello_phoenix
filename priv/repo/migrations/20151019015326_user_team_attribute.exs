defmodule HelloPhoenix.Repo.Migrations.UserTeamAttribute do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :team_id, references(:teams)
    end
  end
end
