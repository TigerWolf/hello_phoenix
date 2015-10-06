defmodule HelloPhoenix.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :event_id, references(:events)

      timestamps
    end
    create index(:teams, [:event_id])

  end
end
