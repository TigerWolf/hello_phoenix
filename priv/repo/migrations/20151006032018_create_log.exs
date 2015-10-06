defmodule HelloPhoenix.Repo.Migrations.CreateLog do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :amount, :integer
      add :activity_id, references(:activities)
      add :user_id, references(:user)

      timestamps
    end
    create index(:logs, [:activity_id])
    create index(:logs, [:user_id])

  end
end
