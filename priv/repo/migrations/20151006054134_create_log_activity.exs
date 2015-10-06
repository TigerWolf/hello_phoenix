defmodule HelloPhoenix.Repo.Migrations.CreateLogActivity do
  use Ecto.Migration

  def change do
    create table(:log_activities) do
      add :activity_id, references(:activities)
      add :log_id, references(:logs)

      timestamps
    end
    create index(:log_activities, [:activity_id])
    create index(:log_activities, [:log_id])

  end
end
